#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '
# Powerline
function _update_ps1() {
    PS1="$(~/powerline-shell/powerline-shell.py $? 2> /dev/null)"
}

BROWSER=/usr/bin/chromium
EDITOR=/usr/bin/nvim
VISUAL=/usr/bin/nvim 
export VISUAL 

# jdownloader / java fix
export _JAVA_AWT_WM_NONREPARENTING=1 

# Wayland settings
# export GDK_BACKEND=wayland
# export CLUTTER_BACKEND=wayland
# export QT_QPA_PLATFORM=wayland-egl
# export ECORE_EVAS_ENGINE=wayland_egl
# export ELM_ENGINE=wayland_egl
# export SDL_VIDEODRIVER=wayland

alias ls='exa -lgahi --group-directories-first --color=always'
alias nano='nano -c'
alias c='clear'
alias mount='mount |column -t'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias wget='wget -c'
alias zz='systemctl suspend'
alias zzzz='systemctl hibernate'
alias unburdenbattery='sudo powertop --auto-tune'
alias scanout='nmap -p- -PN portquiz.net -vvv'
alias louder='sink_nr="$(pacmd list-sinks | grep -o 'index...' | grep -o '.$')"| pactl -- set-sink-volume $sink_nr +5%'
alias mounttrexvideos='sudo mount -t nfs -o nolock 192.168.0.140:/Movies /mnt/trex_movies/'
#alias connect_monitor='xrandr --output eDP1 --auto --output DP2-1 --mode 2560x1440 --right-of eDP1'
alias vboxwin='vboxmanage startvm "Win"'
alias servehere="python3 -m http.server 8080"
alias ffcurl="curl -H \"User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.8) Gecko/2009032609 Firefox/3.0.0 (.NET CLR 3.5.30729)\""
alias cat="bat"
#alias setidf#path='export IDF_PATH=~/workspace/ESP32/esp-idf'
alias h='history'
alias j='jobs -l'
alias bomb=':(){ :|:& }:'
alias calc='bc -l'
alias processes='ps -aux'
alias header='curl -I'
alias update='pikaur -Syu --devel --needed'
alias screenoff="xset dpms force off"
alias flush='sync'
alias vacuum='pacman -Sc'
alias grephistory='history|grep '
alias up='cd ..'
alias r='fc -e -'
alias weather='curl -4 http://wttr.in/'
alias toclipboard='xsel --clipboard'
alias which='type -a'
alias stopwatch='time read'
alias clone_website="wget --recursive --no-clobber --page-requisites --html-extension --convert-links --restrict-file-names=windows --no-parent --domai
ns"
alias show_conn="netstat -tuapen"
alias sway="XKB_DEFAULT_LAYOUT=de sway"

alias makesomenoise='nvlc -Z'
alias ndrinfo='mplayer -playlist http://www.ndr.de/resources/metadaten/audio/m3u/ndrinfo.m3u'
alias radiohamburg='mplayer -playlist http://stream.radiohamburg.de/rhh-live/mp3-192/linkradiohamburgde/play.m3u'
alias nrjhamburg='mplayer http://cdn.nrjaudio.fm/adwz1/de/33009/mp3_128.mp3'
alias nrjberlin='mplayer http://cdn.nrjaudio.fm/adwz1/de/33001/mp3_128.mp3'
alias radiofritz='mplayer https://rbb-mp3-fritz-m.akacast.akamaistream.net/7/799/292093/v1/gnl.akacast.akamaistream.net/rbb_mp3_fritz_m.mp3'

alias tethering='sudo ip link set enp0s20f0u4u4u3 up && sudo systemctl start dhcpcd@enp0s20f0u4u4u3'

#alias startkdeplasma="export XDG_SESSION_TYPE=wayland && export $(dbus-launch) && startplasmacompositor"

eval $(thefuck --alias)

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$PATH:$HOME/workspace/ESP32/xtensa-esp32-elf/bin


if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

function extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.gz)    tar xvzf $1     ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.zip)       unzip $1        ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' error" ;;
        esac
    else
        echo "'$1' error"
    fi
}

function ff() { find . -type f -iname '*'"$*"'*' -ls ; }

portslay () {
    kill -9 `lsof -i tcp:$1 | tail -1 | awk '{ print $2;}'`
}

exip () {
    # gather external ip address
    echo -n "Current External IP: "
    curl -s -m 5 http://myip.dk | grep "ha4" | sed -e 's/.*ha4">//g' -e 's/<\/span>.*//g'
}

# Codi
# Usage: codi [filetype] [filename]
codi() {
  local syntax="${1:-python}"
  shift
  nvim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    let g:codi#width = 48 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}
