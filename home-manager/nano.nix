{ config, pkgs, ... }:

{
  programs.nano = {
    enable = true;

    # On installe nano avec la coloration syntaxique incluse
    package = pkgs.nano;

    # Configuration du fichier .nanorc
    nanorc = ''
      # --- FONCTIONNALITÉS ---
      set linenumbers       # Affiche les numéros de ligne à gauche
      set mouse             # Active la souris (clic pour déplacer le curseur)
      set tabsize 4         # Une tabulation = 4 espaces
      set tabstospaces      # Convertit les tabulations en espaces (mieux pour Python/Nix)
      set autoindent        # Garde l'alignement quand tu fais Entrée
      set smooth            # Défilement fluide (ligne par ligne)
      set constantshow      # Affiche toujours la position (ligne/colonne) en bas
      set softwrap          # Coupe les lignes trop longues visuellement (pas de défilement horizontal infini)
      
      # Fichiers de backup (évite de perdre ton travail si ça plante)
      # set backup
      # set backupdir ~/.nano-backups

      # --- APPARENCE (Style Catppuccin-like) ---
      # Nano utilise les couleurs de ton terminal (Kitty), donc on map juste les éléments
      
      # Interface générale
      set titlecolor bold,white,blue    # La barre du haut
      set numbercolor cyan              # Les numéros de ligne
      set statuscolor bold,white,green  # La barre du bas (infos)
      set errorcolor bold,white,red     # Les messages d'erreur
      set selectedcolor white,magenta   # Le texte sélectionné

      # Coloration du code (Syntax Highlighting générique)
      # Commentaires (Gris)
      # set color cyan "^#.*" 
      
      # Inclusions automatiques des colorations syntaxiques du système
      include "/run/current-system/sw/share/nano/*.nanorc"
    '';
  };
}
