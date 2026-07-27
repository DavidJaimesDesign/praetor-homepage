# Praetor Positioning Notes

## Business Direction

Praetor Home Systems designs, installs, and manages private media systems for
privacy-conscious households. The service brings family photos, home video,
films, music, and selected files into a system built around the home.

The product combines a tailored residential experience with operating practices
drawn from enterprise infrastructure. Clients use the system. Praetor handles
the architecture, installation, updates, monitoring, backup planning, and
recovery documentation.

## Audience

- Privacy-conscious households
- Families with large or growing photo, video, film, and music collections
- Households that want cloud-like access without default public exposure
- Clients who value a system designed around their home instead of a fixed
  consumer plan
- Trusted referral partners such as residential integrators and household
  specialists

## Message Priorities

Lead with:

- Private family media
- Control over where media lives and who can reach it
- A system sized and configured for the household
- Ongoing local management
- The convenience of modern cloud services without public exposure by default

Use the technical stack to explain how Praetor delivers the service:

- Tailscale provides encrypted private access for approved devices.
- Proxmox provides the virtualization and recovery foundation.
- Kubernetes runs services with health checks, controlled restarts, and a
  repeatable deployment model.
- Monitoring, alerts, documented backups, and recovery procedures support
  ongoing operation.

## Language Boundaries

Avoid leading with:

- Digital estate
- Servers
- Homelab
- Self-hosting
- Commodity IT support
- A list of product names without explaining the client benefit

Do not claim:

- Zero-knowledge operation for services that must read content while running
- Public-cloud-scale high availability
- Paid offsite backup coverage until that service is active
- That the client needs to operate Kubernetes, Proxmox, or Tailscale

## Design Direction

The site should feel calm, premium, and residential rather than trendy or
aggressively technical. The writing should sound direct and informed. Technical
details belong on the page, but they should explain reliability and privacy
rather than turn the service into a hobbyist build guide.
