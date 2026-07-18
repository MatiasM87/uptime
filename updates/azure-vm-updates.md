# Azure VM Updates

Generated: 2026-07-18 17:35:51 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 21 |
| OK | 6 |
| Updates pending | 5 |
| Reboot pending | 0 |
| Assessment warnings/errors | 9 |
| Assessment not succeeded | 1 |
| VMs with Ubuntu ESM required patches | 10 |
| Costo mensual AZ acumulado | USD 1,064.34 |
| Total security updates | 912 |
| Total critical updates | 0 |
| Total pending patches listed | 1302 |

## VM Detail

| VM | OS | Status | Security | Critical | Other | ESM | Reboot | Last assessment | Notes |
| --- | --- | --- | ---: | ---: | ---: | ---: | --- | --- | --- |
| devapp-greenpeace-cl-srv | Linux | assessment_warning | 242 | 0 | 59 | 186 | False | 2026-07-18T13:42:16Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 186 | 0 | 0 | 186 | False | 2026-07-18T00:07:12Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 154 | 0 | 0 | 154 | False | 2026-07-18T10:32:10Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 141 | 0 | 0 | 141 | False | 2026-07-18T01:16:15Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 138 | 0 | 0 | 138 | False | 2026-07-18T12:10:08Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 12 | 0 | 6 | 0 | False | 2026-07-18T09:04:36Z |  |
| salvemoslosglaciares-srv | Linux | assessment_warning | 12 | 0 | 6 | 9 | False | 2026-07-18T00:11:49Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 12 | 0 | 3 | 9 | False | 2026-07-18T00:18:37Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-srv | Linux | updates_pending | 5 | 0 | 6 | 0 | False | 2026-07-18T00:31:36Z |  |
| forms-magma-api-srv | Linux | assessment_warning | 5 | 0 | 3 | 2 | False | 2026-07-18T02:12:14Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARG-v2-2024 | Linux | updates_pending | 3 | 0 | 2 | 0 | False | 2026-07-18T12:17:34Z |  |
| openvpn-gpandino | Linux | assessment_warning | 2 | 0 | 0 | 2 | False | 2026-07-14T18:00:20Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| WebSrv-AppCoupon-srv | Linux | assessment_attention | 0 | 0 | 308 | 174 | False | 2026-07-18T02:20:42Z | Ubuntu Pro/ESM likely required |
| greenpos-colombia-srv | Linux | updates_pending | 0 | 0 | 5 | 0 | False | 2026-07-17T13:03:29Z |  |
| ADDI-2024-srv | Windows | updates_pending | 0 | 0 | 0 | 0 | False | 2026-07-18T02:51:18Z |  |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-16T03:53:48Z |  |
| Dominga-HDD-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-17T15:53:30Z |  |
| middleware-gui-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-16T05:08:12Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-16T05:01:50Z |  |
| Monitores-Grafana-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-18T01:13:38Z |  |
| UniFi-Controller-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-16T05:04:40Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
