#!/bin/bash

# ARG_OPTIONAL_SINGLE([globalfile],[g],[Path to global tool-versions file],[$HOME/.tool-versions])
# ARG_HELP([This script will update all versions of installed asdf plugins])
# ARG_VERSION([echo $0 v0.1.0])
# ARGBASH_SET_INDENT([  ])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.10.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info


die()
{
  local _ret="${2:-1}"
  test "${_PRINT_HELP:-no}" = yes && print_help >&2
  echo "$1" >&2
  exit "${_ret}"
}


begins_with_short_option()
{
  local first_option all_short_options='ghv'
  first_option="${1:0:1}"
  test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_globalfile="$HOME/.tool-versions"


print_help()
{
  printf '%s\n' "This script will update all versions of installed asdf plugins"
  printf 'Usage: %s [-g|--globalfile <arg>] [-h|--help] [-v|--version]\n' "$0"
  printf '\t%s\n' "-g, --globalfile: Path to global tool-versions file (default: '$HOME/.tool-versions')"
  printf '\t%s\n' "-h, --help: Prints help"
  printf '\t%s\n' "-v, --version: Prints version"
}


parse_commandline()
{
  while test $# -gt 0
  do
    _key="$1"
    case "$_key" in
      -g|--globalfile)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_globalfile="$2"
        shift
        ;;
      --globalfile=*)
        _arg_globalfile="${_key##--globalfile=}"
        ;;
      -g*)
        _arg_globalfile="${_key##-g}"
        ;;
      -h|--help)
        print_help
        exit 0
        ;;
      -h*)
        print_help
        exit 0
        ;;
      -v|--version)
        echo $0 v0.1.0
        exit 0
        ;;
      -v*)
        echo $0 v0.1.0
        exit 0
        ;;
      *)
        _PRINT_HELP=yes die "FATAL ERROR: Got an unexpected argument '$1'" 1
        ;;
    esac
    shift
  done
}

parse_commandline "$@"

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash


asdf update || true

asdf plugin update --all

PLUGINS=$(cat ${_arg_globalfile} | awk '{ print $1 }')
for plugin in ${PLUGINS[@]}; do
  latest_version=$(asdf latest ${plugin})
  asdf install ${plugin} ${latest_version}
  sed -i "s/${plugin}.*/${plugin} ${latest_version}/g" ${_arg_globalfile}
done




# ] <-- needed because of Argbash
