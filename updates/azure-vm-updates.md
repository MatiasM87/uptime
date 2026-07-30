# Azure VM Updates

Generated: 2026-07-30 03:49:28 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 21 |
| OK | 3 |
| Updates pending | 7 |
| Reboot pending | 0 |
| Assessment warnings/errors | 11 |
| Assessment not succeeded | 1 |
| VMs with Ubuntu ESM required patches | 10 |
| Costo mensual AZ acumulado | USD 1,468.32 |
| Total security updates | 1175 |
| Total critical updates | 0 |
| Total pending patches listed | 1310 |

## Automation and backups

| Metric | Value |
| --- | ---: |
| Published runbooks | 9 |
| Runbooks whose latest job completed | 5 |
| Runbooks whose latest job failed | 2 |
| Protected VMs | 28 |
| Backups reported healthy by Azure | 28 |
| Backups outside their RPO threshold | 11 |

## VM Detail

| VM | OS | Status | Security | Critical | Other | ESM | Reboot | Last assessment | Notes |
| --- | --- | --- | ---: | ---: | ---: | ---: | --- | --- | --- |
| devapp-greenpeace-cl-srv | Linux | assessment_warning | 245 | 0 | 59 | 189 | False | 2026-07-29T22:00:40Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| WebSrv-AppCoupon-srv | Linux | assessment_warning | 244 | 0 | 75 | 185 | False | 2026-07-30T03:43:43Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 189 | 0 | 0 | 189 | False | 2026-07-29T21:59:38Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 157 | 0 | 0 | 157 | False | 2026-07-29T21:59:54Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 144 | 0 | 0 | 144 | False | 2026-07-29T21:29:20Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 141 | 0 | 0 | 141 | False | 2026-07-29T21:29:20Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 32 | 0 | 2 | 0 | False | 2026-07-29T21:29:42Z |  |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 9 | 0 | 2 | 9 | False | 2026-07-29T21:40:43Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| salvemoslosglaciares-srv | Linux | assessment_warning | 9 | 0 | 2 | 9 | False | 2026-07-29T21:29:34Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| forms-magma-api-srv | Linux | assessment_warning | 2 | 0 | 2 | 2 | False | 2026-07-29T21:30:01Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| openvpn-gpandino | Linux | assessment_warning | 2 | 0 | 2 | 2 | False | 2026-07-29T21:58:31Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-srv | Linux | updates_pending | 1 | 0 | 3 | 0 | False | 2026-07-29T21:59:48Z |  |
| middleware-staging | Linux | updates_pending | 0 | 0 | 3 | 0 | False | 2026-07-29T22:28:01Z |  |
| FGARG-v2-2024 | Linux | updates_pending | 0 | 0 | 2 | 0 | False | 2026-07-29T21:29:35Z |  |
| greenpos-colombia-srv | Linux | updates_pending | 0 | 0 | 2 | 0 | False | 2026-07-29T21:29:19Z |  |
| middleware-gui-srv | Linux | updates_pending | 0 | 0 | 2 | 0 | False | 2026-07-29T22:57:57Z |  |
| Monitores-Grafana-srv | Linux | updates_pending | 0 | 0 | 2 | 0 | False | 2026-07-29T21:29:30Z |  |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-07-29T21:59:48Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| ADDI-2024-srv | Windows | ok | 0 | 0 | 0 | 0 | False | 2026-07-30T02:53:51Z |  |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-29T03:53:53Z |  |
| Dominga-HDD-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-29T03:48:54Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
