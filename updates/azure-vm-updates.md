# Azure VM Updates

Generated: 2026-10-25 15:22:14 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 22 |
| OK | 3 |
| Updates pending | 7 |
| Reboot pending | 0 |
| Assessment warnings/errors | 11 |
| Assessment not succeeded | 3 |
| VMs with Ubuntu ESM required patches | 10 |
| Costo mensual AZ acumulado | USD 1,347.54 |
| Total security updates | 751 |
| Total critical updates | 0 |
| Total pending patches listed | 1078 |

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
| Webserver-Ar-Dev | Linux | assessment_warning | 215 | 0 | 0 | 215 | False | 2026-10-24T23:08:41Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 179 | 0 | 2 | 179 | False | 2026-10-25T10:33:02Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 167 | 0 | 0 | 167 | False | 2026-10-24T23:21:55Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 163 | 0 | 0 | 163 | False | 2026-10-24T12:04:21Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| salvemoslosglaciares-srv | Linux | assessment_warning | 9 | 0 | 1 | 9 | False | 2026-10-24T15:34:05Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 9 | 0 | 0 | 9 | False | 2026-10-25T00:08:00Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 5 | 0 | 9 | 0 | False | 2026-10-24T10:05:37Z |  |
| forms-magma-api-srv | Linux | assessment_warning | 2 | 0 | 1 | 2 | False | 2026-10-25T10:52:30Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Monitores-Grafana-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-10-25T09:21:38Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipeit-prod-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-10-22T05:03:09Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| WebSrv-AppCoupon-srv | Linux | assessment_attention | 0 | 0 | 342 | 194 | False | 2026-10-25T03:52:45Z | Ubuntu Pro/ESM likely required |
| middleware-integracion-srv | Linux | updates_pending | 0 | 0 | 9 | 0 | False | 2026-10-25T08:21:35Z |  |
| ADDI-2024-srv | Windows | updates_pending | 0 | 0 | 0 | 0 | False | 2026-10-25T02:51:29Z |  |
| Dominga-HDD-VM | Linux | updates_pending | 0 | 0 | 1 | 0 | False | 2026-10-25T06:02:45Z |  |
| FGARG-v2-2024 | Linux | updates_pending | 0 | 0 | 1 | 0 | False | 2026-10-25T07:21:28Z |  |
| greenpos-colombia-srv | Linux | updates_pending | 0 | 0 | 1 | 0 | False | 2026-10-24T22:10:26Z |  |
| middleware-gui-srv | Linux | updates_pending | 0 | 0 | 1 | 0 | False | 2026-10-25T08:19:47Z |  |
| devapp-greenpeace-cl-srv | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-10-25T09:58:01Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-10-24T21:43:20Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-10-22T03:52:44Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-10-22T05:01:30Z |  |
| netskope-publisher | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-10-22T04:08:20Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
