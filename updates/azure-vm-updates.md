# Azure VM Updates

Generated: 2026-09-29 17:25:19 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 22 |
| OK | 7 |
| Updates pending | 3 |
| Reboot pending | 0 |
| Assessment warnings/errors | 12 |
| Assessment not succeeded | 2 |
| VMs with Ubuntu ESM required patches | 10 |
| Costo mensual AZ acumulado | USD 1,561.77 |
| Total security updates | 1000 |
| Total critical updates | 0 |
| Total pending patches listed | 1055 |

## Automation and backups

| Metric | Value |
| --- | ---: |
| Published runbooks | 9 |
| Runbooks whose latest job completed | 5 |
| Runbooks whose latest job failed | 3 |
| Protected VMs | 29 |
| Backups reported healthy by Azure | 29 |
| Backups outside their RPO threshold | 11 |

## VM Detail

| VM | OS | Status | Security | Critical | Other | ESM | Reboot | Last assessment | Notes |
| --- | --- | --- | ---: | ---: | ---: | ---: | --- | --- | --- |
| WebSrv-AppCoupon-srv | Linux | assessment_warning | 259 | 0 | 77 | 200 | False | 2026-09-29T05:45:19Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 204 | 0 | 0 | 204 | False | 2026-09-29T03:09:20Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 172 | 0 | 2 | 172 | False | 2026-09-29T10:32:07Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 159 | 0 | 0 | 159 | False | 2026-09-29T02:56:41Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 156 | 0 | 0 | 156 | False | 2026-09-29T02:59:37Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 27 | 0 | 6 | 0 | False | 2026-09-29T12:04:18Z |  |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 9 | 0 | 0 | 9 | False | 2026-09-29T03:13:23Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| salvemoslosglaciares-srv | Linux | assessment_warning | 9 | 0 | 0 | 9 | False | 2026-09-29T04:02:26Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| forms-magma-api-srv | Linux | assessment_warning | 2 | 0 | 0 | 2 | False | 2026-09-29T04:54:41Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARG-v2-2024 | Linux | updates_pending | 1 | 0 | 0 | 0 | False | 2026-09-29T16:04:37Z |  |
| Monitores-Grafana-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-09-29T03:03:30Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipeit-prod-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-09-29T05:02:37Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-srv | Linux | updates_pending | 0 | 0 | 6 | 0 | False | 2026-09-29T04:10:10Z |  |
| devapp-greenpeace-cl-srv | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-09-29T15:15:43Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-09-29T03:05:31Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| ADDI-2024-srv | Windows | ok | 0 | 0 | 0 | 0 | False | 2026-09-29T02:53:26Z |  |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-09-29T03:51:44Z |  |
| Dominga-HDD-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-09-29T05:49:04Z |  |
| greenpos-colombia-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-09-29T03:55:13Z |  |
| middleware-gui-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-09-29T03:57:39Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-09-29T05:00:41Z |  |
| netskope-publisher | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-09-29T04:04:35Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
