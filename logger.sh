TL=┌ T=┬ TR=┐
 L=├ M=┼  R=┤
BL=└ B=┴ BR=┘
H=─ V=│   
LV=1

log () {
    if [[ "${LV}" -gt 0 ]]; then
        i=1
        while [[ i -lt "${LV}" ]]; do
            printf "${V}"
            ((i+=1))
        done
    fi
    printf "$@"
    printf "\n"
}

start () {
    log "${TL}$@"
    ((LV+=1))
}

end () {
    ((LV-=1))
    if [[ "${1:-0}" == 0 ]]; then
        log "${BL}done"
    else
        log "${BL}failed"
    fi
    return "${1:-0}"
}
