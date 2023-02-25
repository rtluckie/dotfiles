#!/usr/bin/env bash
set -euf -o pipefail

# Enable nopasswd mode for sudo on macOS from the userspace in fast and totally non-interactive way
#
# Type the password last time to apply the new mode and forget it for any console task for ages
# Use the rollback to restore password protection

if [[ ${USER} != root ]]; then
  echo -e "Script must be run as root..."
  exit 1
else
  sudoers=/private/etc/sudoers
  sudoersd=${sudoers}.d
  sudoersinc="#includedir ${sudoersd}"
  whoami=${SUDO_USER}
  usersudoersd=${sudoersd}/${whoami}-nopasswd
  hostname=$(/bin/hostname -s)

  if [[ $# -gt 1 ]]; then
    echo "Only only argument allowed..."
    exit 1
  fi

  if [[ $# -eq 1 ]]; then
    if [[ $1 == "--undo" ]]; then
      if [ -f ${usersudoersd} ]; then
        /bin/rm -f ${usersudoersd}
        /usr/sbin/visudo -cq
        echo -e "sudo in nopasswd mode has been disabled for ${whoami}@${hostname}"
      else
        echo -e "Sorry, seems this script hasn't been used to enable nopasswd mode for ${whoami}@${hostname}, or it has been already disabled.\nTry to inspect the content of ${sudoersd} folder manually"
      fi
    else
      echo -e "Unrecognized arg $1"
      exit 1
    fi
  else
    [[ -d ${sudoersd} ]] || /bin/mkdir -m755 ${sudoersd}
    if [ -f ${usersudoersd} ]; then
      echo -e "Sorry, seems this script has already been used to enable nopasswd mode for ${whoami}@${hostname}\nTo rollback changes run this script once again with --undo option\n\n\t$(/usr/bin/basename ${0}) --undo\n"
      exit 1
    else
      echo "${whoami} ALL=(ALL:ALL) NOPASSWD: ALL" > ${usersudoersd}
      /bin/chmod 440 ${usersudoersd}
      [[ -f ${sudoers}.default ]] || cp -a ${sudoers} ${sudoers}.default
      /usr/bin/grep "${sudoersinc}" ${sudoers} > /dev/null || echo -e "\n${sudoersinc}" >> ${sudoers}
      /usr/sbin/visudo -cq
      echo -e "Congrats, ${whoami}@${hostname}! nopasswd mode for sudo has been enabled\nTo rollback changes run this script once again with --undo option\n\n\t$(/usr/bin/basename ${0}) --undo\n"
      exit 0
    fi
    [[ $(cat ${sudoers} ${sudoersd}/* | /usr/bin/grep ${whoami} | /usr/bin/wc -l) -ne 1 ]] && echo -e "\n*WARNING* Another mention of ${whoami}@${hostname} has been found at sudoers config files!\nTry to inspect the content of sudoers system config and custom profiles to alter settings manually and avoid possible conflicts\nSystem config: ${sudoers}\nCustom profiles: ${sudoersd}/"
  fi
fi
