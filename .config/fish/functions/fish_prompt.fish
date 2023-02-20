function fish_prompt -d "Write out the prompt"
    printf '[ %s%s%s %s%s%s ]> ' \
        (set_color $fish_color_host) (prompt_hostname) (set_color normal) \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end
