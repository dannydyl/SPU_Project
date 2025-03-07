# User specific environment and startup programs

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.352.b08-2.el8_6.x86_64/jre
export CDS_LICENSE_FILE=5280license4.ece.stonybrook.edu

if [ -z "$LM_LICENSE_FILE" ]; then
    export LM_LICENSE_FILE=5280@license4.ece.stonybrook.edu:29000@license4.ece.stonybrook.edu
else
    export LM_LICENSE_FILE=${LM_LICENSE_FILE}:5280@license4.ece.stonybrook.edu:29000@license4.ece.stonybrook.edu
fi

export XCELIUM_HOME=/usr/local/cds/XCELIUM2409
export VERISIUM_DEBUG_ROOT=/usr/local/cds/VERISIUMDEBUG2409
export CDA_ASSISTANT_HOME=/usr/local/cds/DOCASSISTANT241
 
export QUESTASIM_HOME=/usr/local/mgc/questasim

export  CDA_DOC=$XCELIUM_HOME/doc/:$VERISIUMDEBUG_ROOT/doc:$CDA_DOC
 
PATH=$PATH:$JAVA_HOME/bin:/usr/bin
 
PATH=$PATH:$CDA_ASSISTANT_HOME/bin:$XCELIUM_HOME/tools.lnx86/bin:$XCELIUM_HOME/bin
 
PATH=$PATH:$VERISIUMDEBUG_ROOT/tools.lnx86/bin:$VERISIUMDEBUG_ROOT/bin
export PATH