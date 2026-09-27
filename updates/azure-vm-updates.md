# Azure VM Updates

Generated: 2026-09-27 05:56:19 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 22 |
| OK | 3 |
| Updates pending | 7 |
| Reboot pending | 0 |
| Assessment warnings/errors | 10 |
| Assessment not succeeded | 4 |
| VMs with Ubuntu ESM required patches | 10 |
| Costo mensual AZ acumulado | USD 1,463.99 |
| Total security updates | 590 |
| Total critical updates | 0 |
| Total pending patches listed | 1079 |

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
| Webserver-Ar-Dev | Linux | assessment_warning | 204 | 0 | 0 | 204 | False | 2026-09-26T12:08:20Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 159 | 0 | 0 | 159 | False | 2026-09-26T23:26:14Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 156 | 0 | 0 | 156 | False | 2026-09-26T12:02:57Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 24 | 0 | 6 | 0 | False | 2026-09-27T04:42:57Z |  |
| salvemoslosglaciares-srv | Linux | assessment_warning | 15 | 0 | 1 | 9 | False | 2026-09-26T06:00:38Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 10 | 0 | 0 | 9 | False | 2026-09-26T14:13:48Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| forms-magma-api-srv | Linux | assessment_warning | 8 | 0 | 0 | 2 | False | 2026-09-27T01:01:14Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Dominga-HDD-VM | Linux | updates_pending | 5 | 0 | 0 | 0 | False | 2026-09-26T11:46:34Z |  |
| middleware-gui-srv | Linux | updates_pending | 4 | 0 | 0 | 0 | False | 2026-09-25T05:59:09Z |  |
| Monitores-Grafana-srv | Linux | assessment_warning | 2 | 0 | 0 | 1 | False | 2026-09-26T16:31:18Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-srv | Linux | updates_pending | 1 | 0 | 6 | 0 | False | 2026-09-27T02:14:01Z |  |
| FGARG-v2-2024 | Linux | updates_pending | 1 | 0 | 0 | 0 | False | 2026-09-27T01:23:42Z |  |
| snipeit-prod-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-09-24T05:02:54Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| WebSrv-AppCoupon-srv | Linux | assessment_attention | 0 | 0 | 328 | 183 | False | 2026-09-26T16:52:35Z | Ubuntu Pro/ESM likely required |
| snipe-inventario-srv | Linux | assessment_attention | 0 | 0 | 174 | 172 | False | 2026-09-26T10:33:03Z | Ubuntu Pro/ESM likely required |
| ADDI-2024-srv | Windows | updates_pending | 0 | 0 | 0 | 0 | False | 2026-09-26T14:51:30Z |  |
| greenpos-colombia-srv | Linux | updates_pending | 0 | 0 | 1 | 0 | False | 2026-09-26T11:09:30Z |  |
| devapp-greenpeace-cl-srv | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-09-26T22:49:44Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-09-25T03:04:23Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-09-24T03:52:22Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-09-24T05:01:29Z |  |
| netskope-publisher | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-09-24T04:05:10Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
