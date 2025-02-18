#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <bitset>
#include <unordered_map>
#include <vector>
#include <cctype>

using namespace std;

/*
 * Convert an integer 'value' to a binary string of length 'bits'.
 * Zero-pads (or truncates) on the left as needed.
 */
string toBinary(int value, int bits) {
    // Convert to 32-bit binary, then take the rightmost 'bits'.
    return bitset<32>(value).to_string().substr(32 - bits, bits);
}

/*
 * You have 6 instruction formats:
 *   1) RR
 *   2) RRR
 *   3) RI7
 *   4) RI10
 *   5) RI16
 *   6) RI18
 */
enum class FormatType {
    RR,
    RRR,
    RI7,
    RI10,
    RI16,
    RI18
};

/*
 * For each instruction, store:
 *   - which format it uses,
 *   - its opcode (integer).
 * The opcode size depends on the format (e.g., 4 bits for RRR, 11 bits for RR/RI7, etc.).
 * But we'll store it as an int and rely on the assembler function to take the correct bits.
 */
struct InstructionInfo {
    FormatType format;
    int opcode;  // e.g. 11-bit opcode stored as decimal
};

/*
 * 1) RR format (32 bits total)
 *    Bits [0..10]   = opcode (11 bits)
 *    Bits [11..17]  = RB     (7 bits)
 *    Bits [18..24]  = RA     (7 bits)
 *    Bits [25..31]  = RT     (7 bits)
 */
string assembleRR(int opcode, int rt, int ra, int rb) {
    // According to your layout: [OP(11)][RB(7)][RA(7)][RT(7)]
    // If your assembly is "RR $RT, $RA, $RB", then parse them in that order,
    // but place them in the bit string as specified.
    string opBin = toBinary(opcode, 11);
    string rbBin = toBinary(rb, 7);
    string raBin = toBinary(ra, 7);
    string rtBin = toBinary(rt, 7);
    return opBin + rbBin + raBin + rtBin; // 11 + 7 + 7 + 7 = 32
}

/*
 * 2) RRR format (32 bits)
 *    Bits [0..3]   = opcode (4 bits)
 *    Bits [4..10]  = RT     (7 bits)
 *    Bits [11..17] = RB     (7 bits)
 *    Bits [18..24] = RA     (7 bits)
 *    Bits [25..31] = RC     (7 bits)
 */
string assembleRRR(int opcode, int rt, int rb, int ra, int rc) {
    // [OP(4)][RT(7)][RB(7)][RA(7)][RC(7)]
    string opBin = toBinary(opcode, 4);
    string rtBin = toBinary(rt, 7);
    string rbBin = toBinary(rb, 7);
    string raBin = toBinary(ra, 7);
    string rcBin = toBinary(rc, 7);
    return opBin + rtBin + rbBin + raBin + rcBin; // 4 + 7 + 7 + 7 + 7 = 32
}

/*
 * 3) RI7 format (32 bits)
 *    Bits [0..10]   = opcode (11 bits)
 *    Bits [11..17]  = I7     (7 bits)
 *    Bits [18..24]  = RA     (7 bits)
 *    Bits [25..31]  = RT     (7 bits)
 */
string assembleRI7(int opcode, int imm7, int ra, int rt) {
    // [OP(11)][I7(7)][RA(7)][RT(7)]
    string opBin = toBinary(opcode, 11);
    string i7Bin = toBinary(imm7, 7);
    string raBin = toBinary(ra, 7);
    string rtBin = toBinary(rt, 7);
    return opBin + i7Bin + raBin + rtBin; // 11 + 7 + 7 + 7 = 32
}

/*
 * 4) RI10 format (32 bits)
 *    Bits [0..7]   = opcode (8 bits)
 *    Bits [8..17]  = I10    (10 bits)
 *    Bits [18..24] = RA     (7 bits)
 *    Bits [25..31] = RT     (7 bits)
 */
string assembleRI10(int opcode, int imm10, int ra, int rt) {
    // [OP(8)][I10(10)][RA(7)][RT(7)]
    string opBin  = toBinary(opcode, 8);
    string i10Bin = toBinary(imm10, 10);
    string raBin  = toBinary(ra, 7);
    string rtBin  = toBinary(rt, 7);
    return opBin + i10Bin + raBin + rtBin; // 8 + 10 + 7 + 7 = 32
}

/*
 * 5) RI16 format (32 bits)
 *    Bits [0..8]   = opcode (9 bits)
 *    Bits [9..24]  = I16    (16 bits)
 *    Bits [25..31] = RT     (7 bits)
 *
 * (We assume your doc meant bits [25..31] = 7 bits for RT, so total = 32 bits.)
 */
string assembleRI16(int opcode, int imm16, int rt) {
    // [OP(9)][I16(16)][RT(7)]
    string opBin  = toBinary(opcode, 9);
    string i16Bin = toBinary(imm16, 16);
    string rtBin  = toBinary(rt, 7);
    return opBin + i16Bin + rtBin; // 9 + 16 + 7 = 32
}

/*
 * 6) RI18 format (32 bits)
 *    Bits [0..6]   = opcode (7 bits)
 *    Bits [7..24]  = I18    (18 bits)
 *    Bits [25..31] = RT     (7 bits)
 *
 * (We assume your doc meant bits [25..31] = 7 bits for RT, so total = 32 bits.)
 */
string assembleRI18(int opcode, int imm18, int rt) {
    // [OP(7)][I18(18)][RT(7)]
    string opBin   = toBinary(opcode, 7);
    string i18Bin  = toBinary(imm18, 18);
    string rtBin   = toBinary(rt, 7);
    return opBin + i18Bin + rtBin; // 7 + 18 + 7 = 32
}

/*
 * Example lookup table from mnemonic -> {FormatType, opcode}.
 * You will fill this with real instructions (e.g. "AND", "OR", "ADD", "ADDI", etc.)
 * and the correct opcode bits (in decimal).
 */
unordered_map<string, InstructionInfo> instructionMap = {
    // Example: "AND" uses RR format with an 11-bit opcode of 0x123 (binary 100100011).
    // Just a placeholder. Convert your real opcode bits to decimal and put them here.
    {"AND",  {FormatType::RR, 0x123}},

    // Another example for an RRR-format instruction (4-bit opcode).
    {"MUL",  {FormatType::RRR, 0xC}},  // 0xC in decimal is 1100 in binary.

    // Add more instructions...
};

/*
 * Helper to parse a single operand:
 *   - If it starts with '$', interpret as register (e.g. "$3" => 3).
 *   - If it starts with 'h'/'H', interpret as hex immediate (e.g. "hFF" => 255).
 *   - Otherwise, interpret as decimal (e.g. "42" => 42).
 */
int parseOperand(const string &operand) {
    if (operand.empty()) return 0;

    // Register?
    if (operand[0] == '$') {
        return stoi(operand.substr(1)); // skip '$'
    }
    // Hex immediate?
    if (operand[0] == 'h' || operand[0] == 'H') {
        return stoi(operand.substr(1), nullptr, 16);
    }
    // Decimal immediate
    return stoi(operand);
}

/*
 * Process a single line of assembly: "MNEMONIC operand1, operand2, ..."
 *  - Lookup the mnemonic in instructionMap
 *  - Depending on its FormatType, parse the correct # of operands
 *  - Call the corresponding assemble function
 *  - Return a 32-bit binary string (or empty if error)
 */
string processInstruction(const string &line) {
    // 1) Extract mnemonic
    istringstream iss(line);
    string mnemonic;
    iss >> mnemonic;
    if (mnemonic.empty()) {
        return ""; // skip empty or invalid line
    }

    // 2) Lookup
    auto it = instructionMap.find(mnemonic);
    if (it == instructionMap.end()) {
        cerr << "Error: Unknown instruction '" << mnemonic << "'\n";
        return "";
    }
    InstructionInfo info = it->second;

    // 3) Collect comma-separated operands
    vector<string> operands;
    string opToken;
    while (getline(iss, opToken, ',')) {
        // Trim whitespace
        size_t start = opToken.find_first_not_of(" \t");
        size_t end   = opToken.find_last_not_of(" \t");
        if (start != string::npos && end != string::npos) {
            operands.push_back(opToken.substr(start, end - start + 1));
        }
    }

    // 4) Dispatch based on FormatType
    switch (info.format) {
    case FormatType::RR: {
        // Expect assembly: e.g. "AND $rt, $ra, $rb"
        if (operands.size() < 3) {
            cerr << "Error: RR format expects 3 registers.\n";
            return "";
        }
        int rt = parseOperand(operands[0]);
        int ra = parseOperand(operands[1]);
        int rb = parseOperand(operands[2]);
        return assembleRR(info.opcode, rt, ra, rb);
    }
    case FormatType::RRR: {
        // e.g. "MUL $rt, $rb, $ra, $rc"
        if (operands.size() < 4) {
            cerr << "Error: RRR format expects 4 registers.\n";
            return "";
        }
        int rt = parseOperand(operands[0]);
        int rb = parseOperand(operands[1]);
        int ra = parseOperand(operands[2]);
        int rc = parseOperand(operands[3]);
        return assembleRRR(info.opcode, rt, rb, ra, rc);
    }
    case FormatType::RI7: {
        // e.g. "MNEMONIC $rt, $ra, imm7"
        if (operands.size() < 3) {
            cerr << "Error: RI7 expects 3 operands (RT, RA, I7).\n";
            return "";
        }
        int rt  = parseOperand(operands[0]);
        int ra  = parseOperand(operands[1]);
        int imm = parseOperand(operands[2]);
        return assembleRI7(info.opcode, imm, ra, rt);
    }
    case FormatType::RI10: {
        // e.g. "MNEMONIC $rt, $ra, imm10"
        if (operands.size() < 3) {
            cerr << "Error: RI10 expects 3 operands (RT, RA, I10).\n";
            return "";
        }
        int rt  = parseOperand(operands[0]);
        int ra  = parseOperand(operands[1]);
        int imm = parseOperand(operands[2]);
        return assembleRI10(info.opcode, imm, ra, rt);
    }
    case FormatType::RI16: {
        // e.g. "MNEMONIC $rt, imm16"
        // or "MNEMONIC $rt, $ra, imm16" if your doc says so. Adjust as needed.
        if (operands.size() < 2) {
            cerr << "Error: RI16 expects at least 2 operands (RT, I16).\n";
            return "";
        }
        int rt  = parseOperand(operands[0]);
        int imm = parseOperand(operands[1]);
        return assembleRI16(info.opcode, imm, rt);
    }
    case FormatType::RI18: {
        // e.g. "MNEMONIC $rt, imm18"
        if (operands.size() < 2) {
            cerr << "Error: RI18 expects 2 operands (RT, I18).\n";
            return "";
        }
        int rt   = parseOperand(operands[0]);
        int imm  = parseOperand(operands[1]);
        return assembleRI18(info.opcode, imm, rt);
    }
    }

    // Should not reach here
    return "";
}

int main() {
    ifstream infile("input.txt");
    ofstream outfile("output.txt");
    if (!infile) {
        cerr << "Error opening input.txt\n";
        return 1;
    }
    if (!outfile) {
        cerr << "Error opening output.txt\n";
        return 1;
    }

    string line;
    while (getline(infile, line)) {
        // Skip empty lines
        if (line.empty()) continue;

        // Assemble
        string bits32 = processInstruction(line);
        if (!bits32.empty()) {
            if (bits32.size() != 32) {
                cerr << "Error: Assembled instruction != 32 bits for line: " << line << "\n";
                continue;
            }
            // Write the 32-bit binary to output
            outfile << bits32 << "\n";
        }
    }

    infile.close();
    outfile.close();
    return 0;
}
