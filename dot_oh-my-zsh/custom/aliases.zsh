alias zshconfig="nvim ~/.zshrc"
alias ollama-serve="docker run -it --rm -v ~/docker/ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama serve"
alias ollama="docker exec -it ollama ollama"
alias syncthing-start="systemctl --user start syncthing.service"
alias syncthing-stop="systemctl --user stop syncthing.service"
alias docker-start="sudo systemctl start docker.service && sudo systemctl start containerd.service"
alias docker-stop="sudo systemctl stop docker.service && sudo systemctl stop containerd.service"

esptool() {
    local device="$1"
    
    # Verifica se è stato specificato un dispositivo
    if [ -z "$device" ]; then
        echo "Uso: esptool <dispositivo> <comandi>"
        echo "Esempio: esptool /dev/ttyUSB0 flash_id"
        return 1
    fi
    
    # Verifica se il dispositivo esiste
    if [ ! -e "$device" ]; then
        echo "Errore: Il dispositivo $device non esiste"
        return 1
    fi
    
    shift  # Rimuove il primo argomento (device) lasciando solo i comandi per esptool
    
    # Esegue esptool con il dispositivo specificato
    docker run --rm -it \
        --device="$device":"$device" \
        -v "$PWD":/workspace \
        --workdir /workspace \
        espressif/idf:latest esptool.py -p "$device" "$@"
}
