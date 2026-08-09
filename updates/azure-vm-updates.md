# Azure VM Updates

Generated: 2026-08-09 02:55:27 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 20 |
| OK | 6 |
| Updates pending | 4 |
| Reboot pending | 0 |
| Assessment warnings/errors | 9 |
| Assessment not succeeded | 2 |
| VMs with Ubuntu ESM required patches | 9 |
| Costo mensual AZ acumulado | USD 462.91 |
| Total security updates | 950 |
| Total critical updates | 0 |
| Total pending patches listed | 1344 |

## Automation and backups

| Metric | Value |
| --- | ---: |
| Published runbooks | 9 |
| Runbooks whose latest job completed | 5 |
| Runbooks whose latest job failed | 3 |
| Protected VMs | 28 |
| Backups reported healthy by Azure | 28 |
| Backups outside their RPO threshold | 11 |

## VM Detail

| VM | OS | Status | Security | Critical | Other | ESM | Reboot | Last assessment | Notes |
| --- | --- | --- | ---: | ---: | ---: | ---: | --- | --- | --- |
| devapp-greenpeace-cl-srv | Linux | assessment_warning | 245 | 0 | 61 | 189 | False | 2026-08-08T13:47:58Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 189 | 0 | 2 | 189 | False | 2026-08-08T00:39:39Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 157 | 0 | 2 | 157 | False | 2026-08-08T10:33:17Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 144 | 0 | 0 | 144 | False | 2026-08-08T12:14:15Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 141 | 0 | 0 | 141 | False | 2026-08-08T12:03:16Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 38 | 0 | 13 | 0 | False | 2026-08-08T14:15:24Z |  |
| forms-magma-api-srv | Linux | assessment_warning | 18 | 0 | 0 | 2 | False | 2026-08-08T12:50:36Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| salvemoslosglaciares-srv | Linux | assessment_warning | 9 | 0 | 4 | 9 | False | 2026-08-08T15:22:00Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 9 | 0 | 0 | 9 | False | 2026-08-08T07:37:07Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| WebSrv-AppCoupon-srv | Linux | assessment_attention | 0 | 0 | 313 | 172 | False | 2026-08-08T02:12:43Z | Ubuntu Pro/ESM likely required |
| middleware-integracion-srv | Linux | updates_pending | 0 | 0 | 13 | 0 | False | 2026-08-08T13:45:23Z |  |
| greenpos-colombia-srv | Linux | updates_pending | 0 | 0 | 4 | 0 | False | 2026-08-08T11:39:06Z |  |
| ADDI-2024-srv | Windows | updates_pending | 0 | 0 | 0 | 0 | False | 2026-08-08T02:51:16Z |  |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-08-07T21:49:54Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-06T04:03:27Z |  |
| Dominga-HDD-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-08T13:51:19Z |  |
| FGARG-v2-2024 | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-08T12:52:09Z |  |
| middleware-gui-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-06T06:18:39Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-06T05:09:04Z |  |
| Monitores-Grafana-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-08T23:08:45Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
