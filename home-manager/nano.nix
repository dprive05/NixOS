{ config, pkgs, ... }:

{
  # 1. On installe le paquet Nano (Méthode classique)
  home.packages = [ pkgs.nano ];

  # 2. On crée le fichier de configuration manuellement
  # Cela contourne l'erreur "option does not exist"
  home.file.".nanorc".text = ''
      # --- FONCTIONNALITÉS ---
      set linenumbers       # Numéros de ligne
      set mouse             # Souris active
      set tabsize 4         # Tabulation
      set tabstospaces      # Espaces au lieu de tab
      set autoindent
      set smooth
      set constantshow
      set softwrap
      
      # --- APPARENCE (Style Catppuccin-like) ---
      set titlecolor bold,white,blue
      set numbercolor cyan
      set statuscolor bold,white,green
      set errorcolor bold,white,red
      set selectedcolor white,magenta

      # --- COLORATION SYNTAXIQUE ---
      # On va chercher les fichiers de couleur directement dans le paquet installé
      include "${pkgs.nano}/share/nano/*.nanorc"
  '';
}
