# Make file for Lexilla on Windows Visual C++ version
# Copyright 2019 by Neil Hodgson <neilh@scintilla.org>
# The License.txt file describes the conditions under which this software may be distributed.
# This makefile is for using Visual C++ with nmake.
# Usage for Microsoft:
#     nmake -f lexilla.mak
# For debug versions define DEBUG on the command line:
#     nmake DEBUG=1 -f lexilla.mak
# To build with GCC or Clang, run makefile

.SUFFIXES: .cxx

DIR_O=.
DIR_BIN=..\bin

LEXILLA=$(DIR_BIN)\lexilla.dll
LIBLEXILLA=$(DIR_BIN)\liblexilla.lib

LD=link

!IFDEF SUPPORT_XP
ADD_DEFINE=-D_USING_V110_SDK71_
# Different subsystems for 32-bit and 64-bit Windows XP so detect based on Platform
# environment vairable set by vcvars*.bat to be either x86 or x64
!IF "$(PLATFORM)" == "x64"
SUBSYSTEM=-SUBSYSTEM:WINDOWS,5.02
!ELSE
SUBSYSTEM=-SUBSYSTEM:WINDOWS,5.01
!ENDIF
!ELSE
CETCOMPAT=-CETCOMPAT
!IFDEF ARM64
ADD_DEFINE=-D_ARM64_WINAPI_PARTITION_DESKTOP_SDK_AVAILABLE=1
SUBSYSTEM=-SUBSYSTEM:WINDOWS,10.00
!ENDIF
!ENDIF

CRTFLAGS=-D_CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES=1 -D_CRT_SECURE_NO_DEPRECATE=1 -D_SCL_SECURE_NO_WARNINGS=1 $(ADD_DEFINE)
CXXFLAGS=-Zi -TP -MP -W4 -EHsc -std:c++17 $(CRTFLAGS)
CXXDEBUG=-Od -MTd -DDEBUG
CXXNDEBUG=-O1 -MT -DNDEBUG -GL
NAME=-Fo
LDFLAGS=-OPT:REF -LTCG -IGNORE:4197 -DEBUG $(SUBSYSTEM) $(CETCOMPAT)
LDDEBUG=
LIBS=
NOLOGO=-nologo

!IFDEF QUIET
CXX=@$(CXX)
CXXFLAGS=$(CXXFLAGS) $(NOLOGO)
LDFLAGS=$(LDFLAGS) $(NOLOGO)
!ENDIF

!IFDEF DEBUG
CXXFLAGS=$(CXXFLAGS) $(CXXDEBUG)
LDFLAGS=$(LDDEBUG) $(LDFLAGS)
!ELSE
CXXFLAGS=$(CXXFLAGS) $(CXXNDEBUG)
!ENDIF

INCLUDEDIRS=-I../include -I../../scintilla/include -I../src -I../lexlib
CXXFLAGS=$(CXXFLAGS) $(INCLUDEDIRS)

all:	$(LEXILLA) $(LIBLEXILLA)

clean:
	-del /q $(DIR_O)\*.obj $(DIR_O)\*.o $(DIR_O)\*.pdb \
	$(DIR_O)\*.res $(DIR_BIN)\*.map $(DIR_BIN)\*.exp $(DIR_BIN)\*.pdb $(DIR_BIN)\lexilla.lib \
	$(LEXILLA) $(LIBLEXILLA)

depend:
	pyw DepGen.py

#++Autogenerated -- run scripts/LexGen.py to regenerate
#**LEX_OBJS=\\\n\(\t$(DIR_O)\\\*.obj \\\n\)
LEX_OBJS=\
	$(DIR_O)\LexAsm.obj \
	$(DIR_O)\LexAU3.obj \
	$(DIR_O)\LexAVS.obj \
	$(DIR_O)\LexBash.obj \
	$(DIR_O)\LexBatch.obj \
	$(DIR_O)\LexCmake.obj \
	$(DIR_O)\LexCoffeeScript.obj \
	$(DIR_O)\LexConf.obj \
	$(DIR_O)\LexCPP.obj \
	$(DIR_O)\LexCSS.obj \
	$(DIR_O)\LexD.obj \
	$(DIR_O)\LexDiff.obj \
	$(DIR_O)\LexFortran.obj \
	$(DIR_O)\LexHTML.obj \
	$(DIR_O)\LexInno.obj \
	$(DIR_O)\LexJulia.obj \
	$(DIR_O)\LexKix.obj \
	$(DIR_O)\LexLaTeX.obj \
	$(DIR_O)\LexLua.obj \
	$(DIR_O)\LexMake.obj \
	$(DIR_O)\LexMatlab.obj \
	$(DIR_O)\LexNim.obj \
	$(DIR_O)\LexNsis.obj \
	$(DIR_O)\LexNull.obj \
	$(DIR_O)\LexPascal.obj \
	$(DIR_O)\LexPerl.obj \
	$(DIR_O)\LexPowerShell.obj \
	$(DIR_O)\LexProps.obj \
	$(DIR_O)\LexR.obj \
	$(DIR_O)\LexRegistry.obj \
	$(DIR_O)\LexRuby.obj \
	$(DIR_O)\LexRust.obj \
	$(DIR_O)\LexSQL.obj \
	$(DIR_O)\LexTCL.obj \
	$(DIR_O)\LexVB.obj \
	$(DIR_O)\LexVHDL.obj \
	$(DIR_O)\LexYAML.obj \
	$(DIR_O)\LexAHK.obj \
	$(DIR_O)\LexCSV.obj \
	$(DIR_O)\LexDart.obj \
	$(DIR_O)\LexerUtils.obj \
	$(DIR_O)\LexJSON.obj \
	$(DIR_O)\LexKotlin.obj \
	$(DIR_O)\LexMarkdown.obj \
	$(DIR_O)\LexPython.obj \
	$(DIR_O)\LexTOML.obj \

#--Autogenerated -- end of automatically generated section

# Required by lexers
LEXLIB_OBJS=\
	$(DIR_O)\Accessor.obj \
	$(DIR_O)\CharacterCategory.obj \
	$(DIR_O)\CharacterSet.obj \
	$(DIR_O)\DefaultLexer.obj \
	$(DIR_O)\LexAccessor.obj \
	$(DIR_O)\LexerBase.obj \
	$(DIR_O)\LexerModule.obj \
	$(DIR_O)\LexerSimple.obj \
	$(DIR_O)\PropSetSimple.obj \
	$(DIR_O)\StyleContext.obj \
	$(DIR_O)\WordList.obj

# Required by libraries and DLLs that include lexing
LEXILLA_OBJS=\
	$(DIR_O)\Lexilla.obj \
	$(LEXLIB_OBJS) \
	$(LEX_OBJS)

$(LEXILLA): $(LEXILLA_OBJS) LexillaVersion.res
	$(LD) $(LDFLAGS) -DEF:Lexilla.def -DLL -OUT:$@ $** $(LIBS)

$(LIBLEXILLA): $(LEXILLA_OBJS)
	LIB -OUT:$@ $**

# Define how to build all the objects and what they depend on

{..\lexlib}.cxx{$(DIR_O)}.obj::
	$(CXX) $(CXXFLAGS) -c $(NAME)$(DIR_O)\ $<
{..\lexers}.cxx{$(DIR_O)}.obj::
	$(CXX) $(CXXFLAGS) -c $(NAME)$(DIR_O)\ $<
{.}.cxx{$(DIR_O)}.obj::
	$(CXX) $(CXXFLAGS) -c $(NAME)$(DIR_O)\ $<

.rc.res:
	$(RC) -fo$@ $**

# Dependencies

!IF EXISTS(nmdeps.mak)

# Protect with !IF EXISTS to handle accidental deletion - just 'nmake -f lexilla.mak deps'

!INCLUDE nmdeps.mak

!ENDIF
