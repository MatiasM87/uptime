# Azure VM Updates

Generated: 2026-11-17 20:18:50 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 23 |
| OK | 8 |
| Updates pending | 2 |
| Reboot pending | 0 |
| Assessment warnings/errors | 11 |
| Assessment not succeeded | 2 |
| VMs with Ubuntu ESM required patches | 11 |
| Costo mensual AZ acumulado | USD 1,017.37 |
| Total security updates | 1090 |
| Total critical updates | 0 |
| Total pending patches listed | 1197 |

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
| WebSrv-AppCoupon-srv | Linux | assessment_warning | 277 | 0 | 83 | 218 | False | 2026-11-17T05:37:25Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 222 | 0 | 0 | 222 | False | 2026-11-17T14:06:09Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 183 | 0 | 3 | 183 | False | 2026-11-17T10:32:17Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 173 | 0 | 0 | 173 | False | 2026-11-17T02:55:20Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 169 | 0 | 0 | 169 | False | 2026-11-17T02:56:47Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 39 | 0 | 27 | 0 | False | 2026-11-16T23:06:22Z |  |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 10 | 0 | 0 | 10 | False | 2026-11-17T14:06:24Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| salvemoslosglaciares-srv | Linux | assessment_warning | 10 | 0 | 0 | 10 | False | 2026-11-17T03:59:38Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| openvpn-gpandino | Linux | assessment_warning | 2 | 0 | 29 | 2 | False | 2026-11-11T21:55:32Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| forms-magma-api-srv | Linux | assessment_warning | 2 | 0 | 0 | 2 | False | 2026-11-17T04:53:21Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-srv | Linux | updates_pending | 1 | 0 | 25 | 0 | False | 2026-11-16T20:40:44Z |  |
| Monitores-Grafana-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-11-17T14:00:19Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipeit-prod-srv | Linux | assessment_warning | 1 | 0 | 0 | 1 | False | 2026-11-17T05:00:20Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| devapp-greenpeace-cl-srv | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-11-17T20:18:34Z |  |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-11-17T20:18:34Z |  |
| ADDI-2024-srv | Windows | ok | 0 | 0 | 0 | 0 | False | 2026-11-17T02:53:32Z |  |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-17T03:52:36Z |  |
| Dominga-HDD-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-17T10:32:58Z |  |
| FGARG-v2-2024 | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-17T04:56:01Z |  |
| greenpos-colombia-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-17T03:54:54Z |  |
| middleware-gui-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-17T03:56:55Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-17T04:58:25Z |  |
| netskope-publisher | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-11-17T04:02:04Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
