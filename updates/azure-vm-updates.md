# Azure VM Updates

Generated: 2026-08-02 13:05:30 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 21 |
| OK | 5 |
| Updates pending | 5 |
| Reboot pending | 0 |
| Assessment warnings/errors | 10 |
| Assessment not succeeded | 2 |
| VMs with Ubuntu ESM required patches | 10 |
| Costo mensual AZ acumulado | USD 41.84 |
| Total security updates | 946 |
| Total critical updates | 0 |
| Total pending patches listed | 1330 |

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
| devapp-greenpeace-cl-srv | Linux | assessment_warning | 245 | 0 | 59 | 189 | False | 2026-08-02T00:45:14Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 189 | 0 | 0 | 189 | False | 2026-08-01T11:08:25Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 157 | 0 | 0 | 157 | False | 2026-08-02T10:32:49Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 144 | 0 | 0 | 144 | False | 2026-08-01T23:24:13Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 141 | 0 | 0 | 141 | False | 2026-08-01T23:06:15Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 36 | 0 | 7 | 0 | False | 2026-08-02T03:05:20Z |  |
| salvemoslosglaciares-srv | Linux | assessment_warning | 12 | 0 | 6 | 9 | False | 2026-08-02T02:36:51Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 12 | 0 | 0 | 9 | False | 2026-08-02T07:54:16Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| forms-magma-api-srv | Linux | assessment_warning | 4 | 0 | 0 | 2 | False | 2026-08-02T00:05:17Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-srv | Linux | updates_pending | 2 | 0 | 7 | 0 | False | 2026-08-02T00:30:32Z |  |
| openvpn-gpandino | Linux | assessment_warning | 2 | 0 | 2 | 2 | False | 2026-07-29T21:58:31Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-gui-srv | Linux | updates_pending | 2 | 0 | 0 | 0 | False | 2026-07-31T04:33:37Z |  |
| WebSrv-AppCoupon-srv | Linux | assessment_attention | 0 | 0 | 311 | 174 | False | 2026-08-01T13:14:43Z | Ubuntu Pro/ESM likely required |
| greenpos-colombia-srv | Linux | updates_pending | 0 | 0 | 6 | 0 | False | 2026-08-02T09:14:22Z |  |
| ADDI-2024-srv | Windows | updates_pending | 0 | 0 | 0 | 0 | False | 2026-08-01T14:51:26Z |  |
| UniFi-Controller-VM | Linux | assessment_attention | 0 | 0 | 0 | 0 | False | 2026-08-01T21:59:42Z | 2 error/s reported. The latest 2 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-30T03:54:38Z |  |
| Dominga-HDD-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-02T02:48:17Z |  |
| FGARG-v2-2024 | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-01T23:54:25Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-30T05:01:20Z |  |
| Monitores-Grafana-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-08-01T15:10:54Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
