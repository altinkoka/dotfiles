if status is-interactive
    # Commands to run in interactive sessions can go here
end
alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."
alias ..='cd ..'
alias c='clear'
alias gh='history|grep'
alias grep='grep --color=auto'
alias h='history'
alias ipe='curl ipinfo.io/ip'
alias l='ls -lav --ignore=.?*'
alias ll='ls -lav --ignore=..'
alias ls='ls --color=auto'
alias ping='ping -c 5'
alias port='netstat -tulp |grep'
alias ports='netstat -tulpn'
alias server='ssh root@38.242.192.8'
alias sha='shasum -a 256 '
alias speed='speedtest-cli'
alias ss='ls |grep'
alias untar='tar -zxvf'
alias wget='wget -c'


# ------ Power Management -----
alias r='reboot'
alias p='poweroff'

# ----- Package Manager ---- 
alias pacr='sudo pacman -Rsc'
alias pacs='sudo pacman -Ss'
alias pacsyu='sudo pacman -Syu'
alias yayr='yay -Rsc'
alias yays='yay -Ss'
alias yaysyu='yay -Syu'


# ------- Config -------
alias hconfig='vim .config/hypr/hyprland.conf'
alias fconfig='vim .config/fish/config.fish'
alias bconfig='vim .config/hypr/waybar/config'


#----  Pkg List ----------
alias yaylist='pacman -Qqem > $HOME/dotfiles/dotfiles/yaylist.txt'
alias paclist='pacman -Qqen > $home/dotfiles/dotfiles/paclist.txt'

#----- Systemctl ------
alias sysstatus='sudo systemctl status'
alias sysenable='sudo systemctl enable'
alias sysreload='sudo systemctl reload' 
alias sysstop='sudo systemctl stop'
