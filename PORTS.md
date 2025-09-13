Ports follow some rules about how they are numbered:

- X000:
  - 9000: Capytal;
  - 8000: Abaduh;
  - 3000: Internal/Common services;
- 0X00:
  - 0900: Public services (Git forge, websites, etc);
  - 0700: Private services (only accessible via VPN);
  - 0400: Internal services for public(databases, s3 storage, etc);
  - 0800: Public admin services (e.g. analytics.capytal.company dashboard)
  - 0600: Private admin services (e.g. database dashboards);
  - 0300: Internal services for private (databases, s3 storage, etc);
  - 0200: Shared/Common internal services (databases, s3 storage, etc);
