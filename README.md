# Metarisc Docker Container Images

Ce dépôt est collection d'images Docker pour les projets Metarisc.
Ils permettent d'avoir un socle d'environnement pré-configuré de développement, de test et de production pour les projets Metarisc.

## Images

### `php8.2-cli-alpine`

Cette image contient PHP 8.2 avec les extensions courantes pour le développement et l'exécution de scripts PHP en ligne de commande.
Elle est basée sur Alpine Linux pour une taille réduite et une exécution rapide.

Outils inclus :
- [PHP 8.2](https://hub.docker.com/layers/library/php/8.2-cli-alpine/images/sha256-ddfa7091b50bdbb5fd164f03e9c445c2f62697161ae8620894fd8282d9a244df)
- Extensions PHP courantes (comme `pcntl`, `bcmath`, `opcache`, `intl`, etc ...)
- Packages alpine de base (comme `icu-dev`, etc ...)
- [php-extension-installer](https://github.com/mlocati/docker-php-extension-installer)
- Supervisor
- Support des bases de données (Postgresql, MySQL, SQLite)

La configuration de PHP est pré-configurée pour un usage général, mais peut être personnalisée :
- En modifiant le fichier `/usr/local/etc/php/php.ini` pour adapter la configuration de PHP.
- En ajoutant des fichiers de configuration supplémentaires dans le répertoire `/usr/local/etc/php/conf.d/`.
- En ajoutant des extensions PHP supplémentaires via le script `docker-php-ext-install` ou `docker-php-ext-enable`.
- En ajoutant des fichiers de configuration supplémentaires dans le répertoire `/docker-entrypoint.d/`.

### `php8.2-nginx-alpine`

Cette image contient PHP 8.2 avec Nginx, optimisée pour servir des applications web.
Elle est également basée sur Alpine Linux pour une taille réduite et une exécution rapide.

La configuration du couple FPM / Nginx est pré-configurée, il est possible de la personnaliser  :
- En modifiant le fichier `/usr/local/etc/php/php.ini` pour adapter la configuration de PHP.
- En ajoutant des fichiers de configuration supplémentaires dans le répertoire `/usr/local/etc/php/conf.d/`.
- En ajoutant des extensions PHP supplémentaires via le script `docker-php-ext-install` ou `docker-php-ext-enable`.
- En modifiant le fichier `/etc/nginx/nginx.conf` et `/etc/nginx/conf.d/default.conf` pour adapter la configuration de Nginx.
- En modifiant le fichier `/usr/local/etc/php-fpm.d/www.conf` pour adapter la configuration de PHP-FPM.
- En ajoutant des fichiers de configuration supplémentaires dans les répertoires `/etc/nginx/conf.d/` et `/usr/local/etc/php-fpm.d/`.
- En ajoutant des fichiers de configuration supplémentaires dans le répertoire `/docker-entrypoint.d/`.

Outils inclus :
- [PHP 8.2 & FPM](https://hub.docker.com/layers/library/php/8.2-fpm-alpine/images/sha256-132d7ccc156178ced13ac3d88c105eef938394d63e2885f7f2ee8566d06eeb73)
- Nginx
- Extensions PHP courantes (comme `pcntl`, `bcmath`, `opcache`, `intl`, etc ...)
- Packages alpine de base (comme `icu-dev`, `envsubst`, etc ...)
- [php-extension-installer](https://github.com/mlocati/docker-php-extension-installer)
- Supervisor
- Support des bases de données (Postgresql, MySQL, SQLite)