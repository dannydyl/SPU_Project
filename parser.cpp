#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <bitset>
#include <unordered_map>
#include <vector>
#include <cctype>
#include <iomanip>  
using namespace std;

/*
 * Convert an integer 'value' to a binary string of length 'bits'.
 * Zero-pads (or truncates) on the left as needed.
 */
// value may be negative. bits is the field width you need (7,10,16,18,…)
string toBinary(int value, int bits) {
    auto s = bitset<32>(value).to_string();
    return s.substr(32 - bits);
}

/*
 * 6 instruction formats:
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
    {"addx", {FormatType::RR, 0b01101000000}},
    {"ah", {FormatType::RR, 0b00011001000}},
    {"ahi", {FormatType::RI10, 0b00011101}},
    {"a", {FormatType::RR, 0b00011000000}},
    {"ai", {FormatType::RI10, 0b00011100}},
    {"and", {FormatType::RR, 0b00011000001}},
    {"andhi", {FormatType::RI10, 0b00010101}},
    {"andi", {FormatType::RI10, 0b00010100}},
    {"bg", {FormatType::RR, 0b00001000010}},
    {"bgx", {FormatType::RR, 0b01101000011}},
    {"cg", {FormatType::RR, 0b00011000010}},
    {"cgx", {FormatType::RR, 0b01101000010}},
    {"ceqh", {FormatType::RR, 0b01111001000}},
    {"ceqhi", {FormatType::RI10, 0b01111101}},
    {"ceq", {FormatType::RR, 0b01111000000}},
    {"ceqi", {FormatType::RI10, 0b01111100}},
    {"cgth", {FormatType::RR, 0b01001001000}},
    {"cgthi", {FormatType::RI10, 0b01001101}},
    {"cgt", {FormatType::RR, 0b01001000000}},
    {"cgti", {FormatType::RI10, 0b01001100}},
    {"clz", {FormatType::RR, 0b01010100101}},
    {"eqv", {FormatType::RR, 0b01001001001}},
    {"xor", {FormatType::RR, 0b01001000001}},
    {"xorhi", {FormatType::RI10, 0b01000101}},
    {"xori", {FormatType::RI10, 0b01000100}},
    {"ila", {FormatType::RI18, 0b0100001}},
    {"ilh", {FormatType::RI16, 0b010000011}},
    {"ilhu", {FormatType::RI16, 0b010000010}},
    {"il", {FormatType::RI16, 0b010000001}},
    {"iohl", {FormatType::RI16, 0b011000001}},
    {"nand", {FormatType::RR, 0b00011001001}},
    {"nor", {FormatType::RR, 0b00001001001}},
    {"or", {FormatType::RR, 0b00001000001}},
    {"orhi", {FormatType::RI10, 0b00000101}},
    {"ori", {FormatType::RI10, 0b00000100}},
    {"selb", {FormatType::RRR, 0b1000}},
    {"sfx", {FormatType::RR, 0b01101000001}},
    {"sfh", {FormatType::RR, 0b00001001000}},
    {"sfhi", {FormatType::RI10, 0b00001101}},
    {"sf", {FormatType::RR, 0b00001000000}},
    {"sfi", {FormatType::RI10, 0b00001100}},
    {"roth", {FormatType::RR, 0b00001011100}},
    {"rothi", {FormatType::RI7, 0b00001111100}},
    {"rot", {FormatType::RR, 0b00001011000}},
    {"roti", {FormatType::RI7, 0b00001111000}},
    {"shlh", {FormatType::RR, 0b00001011111}},
    {"shlhi", {FormatType::RI7, 0b00001111111}},
    {"shl", {FormatType::RR, 0b00001011011}},
    {"shli", {FormatType::RI7, 0b00001111011}},
    {"fa", {FormatType::RR, 0b01011000100}},
    {"fm", {FormatType::RR, 0b01011000110}},
    {"fma", {FormatType::RRR, 0b1110}},
    {"fms", {FormatType::RRR, 0b1111}},
    {"fnms", {FormatType::RRR, 0b1101}},
    {"fs", {FormatType::RR, 0b01011000101}},
    {"mpy", {FormatType::RR, 0b01111000100}},
    {"mpya", {FormatType::RRR, 0b1100}},
    {"mpyi", {FormatType::RI10, 0b01110100}},
    {"mpyu", {FormatType::RR, 0b01111001100}},
    {"mpyui", {FormatType::RI10, 0b01110101}},
    {"mpyh", {FormatType::RR, 0b01111000101}},
    {"cntb", {FormatType::RR, 0b01010110100}},
    {"absdb", {FormatType::RR, 0b00001010011}},
    {"sumb", {FormatType::RR, 0b01001010011}},
    {"avgb", {FormatType::RR, 0b00011010011}},
    {"rotqbyi", {FormatType::RI7, 0b00111111100}},
    {"rotqby", {FormatType::RR, 0b00111011100}},
    {"rotqbii", {FormatType::RI7, 0b00111111000}},
    {"rotqbi", {FormatType::RR, 0b00111011000}},
    {"shlqbii", {FormatType::RI7, 0b00111111011}},
    {"shlqbi", {FormatType::RR, 0b00111011011}},
    {"shlqbyi", {FormatType::RI7, 0b00111111111}},
    {"shlqby", {FormatType::RR, 0b00111011111}},
    {"lqd", {FormatType::RI10, 0b00110100}},
    {"lqa", {FormatType::RI16, 0b001100001}},
    {"stqa", {FormatType::RI16, 0b001000001}},
    {"stqd", {FormatType::RI10, 0b00100100}},
    {"bra", {FormatType::RI16, 0b001100000}},
    {"brhnz", {FormatType::RI16, 0b001000110}},
    {"brz", {FormatType::RI16, 0b001000000}},
    {"brnz", {FormatType::RI16, 0b001000010}},
    {"brasl", {FormatType::RI16, 0b001100010}},
    {"brsl", {FormatType::RI16, 0b001100110}},
    {"br", {FormatType::RI16, 0b001100100}},
    {"brhz", {FormatType::RI16, 0b001000100}},
    {"lnop", {FormatType::RR, 0b00000000001}},
    {"nop", {FormatType::RR, 0b01000000001}},
    {"stop", {FormatType::RR, 0b00000000000}},
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

// Parses "imm($reg)" syntax for D-form
pair<int, int> parseDFormOperand(const string& operand) {
    size_t openParen = operand.find('(');
    size_t closeParen = operand.find(')');
    if (openParen == string::npos || closeParen == string::npos || closeParen <= openParen)
        return {0, 0}; // Default fallback

    string immStr = operand.substr(0, openParen);
    string regStr = operand.substr(openParen + 1, closeParen - openParen - 1);

    int imm = parseOperand(immStr);
    int ra = parseOperand(regStr);
    return {imm, ra};
}

/*
 * Process a single line of assembly: "MNEMONIC operand1, operand2, ..."
 *  - Lookup the mnemonic in instructionMap
 *  - Depending on its FormatType, parse the correct # of operands
 *  - Call the corresponding assemble function
 *  - Return a 32-bit binary string (or empty if error)
 */
string processInstruction(const string &rawLine, const unordered_map<string, int> &labelMap, int pc) {
    // 1) Extract mnemonic
    // strip inline comment
    size_t cpos = rawLine.find("//");
    string code = (cpos != string::npos
                   ? rawLine.substr(0, cpos)
                   : rawLine);

    // trim whitespace
    size_t start = code.find_first_not_of(" \t");
    if (start == string::npos) return "";
    size_t end   = code.find_last_not_of(" \t");
    code = code.substr(start, end - start + 1);

    // extract mnemonic
    istringstream iss(code);
    string mnemonic;
    iss >> mnemonic;
    if (mnemonic.empty()) return "";
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
        // special case for zero-operand instructions
        if (mnemonic=="nop" ||
            mnemonic=="lnop"||
            mnemonic=="stop") {
            // emit opcode plus all zero registers
            return assembleRR(info.opcode, 0, 0, 0);
        }
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
        if (operands.size() < 2) {
            cerr << "Error: RI10 expects 2 operands (RT, I10(ra)).\n";
            return "";
        }
        int rt = parseOperand(operands[0]);

        // Try parsing the D-form syntax
        int imm = 0, ra = 0;
        if (operands[1].find('(') != string::npos) {
            tie(imm, ra) = parseDFormOperand(operands[1]);
        } else {
            if (operands.size() < 3) {
                cerr << "Error: RI10 expects 3 operands if not using D-form.\n";
                return "";
            }
            ra = parseOperand(operands[1]);
            imm = parseOperand(operands[2]);
        }

        return assembleRI10(info.opcode, imm, ra, rt);
    }
    case FormatType::RI16: {
        int rt  = 0;
        int imm = 0;
        string tok;

        // 1-operand form or 2-operand form
        if (operands.size() == 1) {
            tok = operands[0];
        }
        else if (operands.size() == 2) {
            rt  = parseOperand(operands[0]);
            tok = operands[1];
        }
        else {
            cerr << "Error: RI16 expects one or two operands\n";
            return "";
        }

        // resolve label first
        auto itL = labelMap.find(tok);
        if (itL != labelMap.end()) {
            int targetPC = itL->second + 2;            // absolute target
            if (mnemonic == "bra")
                imm = targetPC;                        // absolute
            else
                imm = targetPC - (pc);             // signed relative
        }
        else {
            // must be a numeric immediate
            try {
                imm = parseOperand(tok);
            }
            catch (const invalid_argument&) {
                cerr << "Error: unknown label or immediate '" << tok << "'\n";
                return "";
            }
        }

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

    // read all lines into memory
    vector<string> allLines;
    {
        ifstream fin("input_assembly.txt");
        if (!fin) { cerr << "Error opening input file\n"; return 1; }
        string raw;
        while (getline(fin, raw))
            allLines.push_back(raw);
    }

    // map label name to instruction index
    unordered_map<string,int> labelMap;
    // filtered list of real instructions
    vector<string> instLines;

    for (auto &raw : allLines) {
        // trim leading plus trailing whitespace
        size_t start = raw.find_first_not_of(" \t");
        if (start == string::npos) continue;
        size_t end = raw.find_last_not_of(" \t");
        string t = raw.substr(start, end - start + 1);

        // skip full-line comments
        if (t.rfind("//", 0) == 0) continue;

        // label if ends with colon
        if (t.back() == ':') {
            string name = t.substr(0, t.size() - 1);
            labelMap[name] = instLines.size();
        }
        else {
            instLines.push_back(t);
        }
    }

    ofstream fout("output_binary.txt");
    if (!fout) { cerr << "Error opening output file\n"; return 1; }

    for (int i = 0; i < (int)instLines.size(); ++i) {
        string bin32 = processInstruction(instLines[i], labelMap, i);
        if (bin32.size() == 32)
            fout << bin32 << "\n";
        else
            cerr << "line " << i
                 << " gave " << bin32.size()
                 << " bits: " << instLines[i] << "\n";
    }


    // // file mode
    // ifstream infile("input_assembly.txt");
    // ofstream outfile("output_binary.txt");
    // if (!infile) {
    //     cerr << "Error opening input_assembly.txt\n";
    //     return 1;
    // }
    // if (!outfile) {
    //     cerr << "Error opening output_binary.txt\n";
    //     return 1;
    // }

    // string line;
    // while (getline(infile, line)) {
    //     // Trim leading whitespace
    //     size_t pos = line.find_first_not_of(" \t");
    //     if (pos == string::npos) continue;  // Skip empty lines

    //     // Check if the first non-whitespace characters form a comment marker (e.g. "//")
    //     if (line.substr(pos, 2) == "//") continue;

    //     // Process the line normally if it's not a comment
    //     string bits32 = processInstruction(line);
    //     if (!bits32.empty()) {
    //         if (bits32.size() != 32) {
    //             cerr << "Error: Assembled instruction != 32 bits for line: " << line << "\n";
    //             continue;
    //         }
    //         outfile << bits32 << "\n";
    //     }
    // }

    // infile.close();
    // outfile.close();

    // print out mode
    // cout << "Enter assembly instructions (type 'exit' to quit):\n";
    // string line;
    // while (true) {
    //     cout << ">> ";
    //     getline(cin, line);
    //     if (line == "exit") break;
    //     string binary = processInstruction(line);
    //     if (!binary.empty() && binary.find("Error") == string::npos) {
    //         // Convert binary to hex correctly
    //         unsigned long value = bitset<32>(binary).to_ulong();
    //         cout << "Binary: " << binary << " | Hex: 0x" << hex << setw(8) << setfill('0') << value << "\n";
    //     } else {
    //         cout << binary << "\n";
    //     }
    // }



    // g++ parser.cpp -o parser
    // ./parser
    return 0;
}