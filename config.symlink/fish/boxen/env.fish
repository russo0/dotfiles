# Make the root of Boxen available.
set -Ux BOXEN_HOME /opt/boxen

# Add homebrew'd stuff to the path.
set -Ux PATH $BOXEN_HOME/homebrew/bin $BOXEN_HOME/homebrew/sbin $PATH

# Add homebrew'd stuff to the manpath.
set -Ux MANPATH $BOXEN_HOME/homebrew/share/man $MANPATH

# Add any binaries specific to Boxen to the path.
set -Ux PATH $BOXEN_HOME/bin $PATH

for f in "$BOXEN_HOME/env.d/*.sh";
  if test -f $f
    . $f
  end
end

# Boxen is active.
if test -d "$BOXEN_HOME/repo/.git"
  set -Ux BOXEN_SETUP_VERSION (set GIT_DIR $BOXEN_HOME/repo/.git git rev-parse --short HEAD)
else
  echo "Boxen could not load properly!"
end
