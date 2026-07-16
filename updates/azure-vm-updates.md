# Azure VM Updates

Generated: 2026-07-16 03:53:58 UTC

Source: Azure Resource Graph patchassessmentresources. This report is read-only: it does not install patches and does not reboot VMs.

## Summary

| Metric | Value |
| --- | ---: |
| VMs with patch assessment | 21 |
| OK | 9 |
| Updates pending | 2 |
| Reboot pending | 0 |
| Assessment warnings/errors | 10 |
| Assessment not succeeded | 0 |
| VMs with Ubuntu ESM required patches | 10 |
| Total security updates | 1132 |
| Total critical updates | 0 |
| Total pending patches listed | 1255 |

## VM Detail

| VM | OS | Status | Security | Critical | Other | ESM | Reboot | Last assessment | Notes |
| --- | --- | --- | ---: | ---: | ---: | ---: | --- | --- | --- |
| devapp-greenpeace-cl-srv | Linux | assessment_warning | 239 | 0 | 59 | 186 | False | 2026-07-16T03:15:10Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| WebSrv-AppCoupon-srv | Linux | assessment_warning | 238 | 0 | 78 | 182 | False | 2026-07-16T03:42:16Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Webserver-Ar-Dev | Linux | assessment_warning | 186 | 0 | 0 | 186 | False | 2026-07-15T16:06:37Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| snipe-inventario-srv | Linux | assessment_warning | 154 | 0 | 0 | 154 | False | 2026-07-15T10:32:07Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| Greenpos-Chile-srv | Linux | assessment_warning | 141 | 0 | 0 | 141 | False | 2026-07-16T02:55:51Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARGv2 | Linux | assessment_warning | 138 | 0 | 0 | 138 | False | 2026-07-16T02:58:41Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| migracion-hubspotmagma-srv | Linux | assessment_warning | 11 | 0 | 0 | 9 | False | 2026-07-16T02:08:35Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| salvemoslosglaciares-srv | Linux | assessment_warning | 10 | 0 | 0 | 9 | False | 2026-07-15T05:06:14Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| middleware-integracion-prod-srv | Linux | updates_pending | 9 | 0 | 1 | 0 | False | 2026-07-16T01:39:29Z |  |
| forms-magma-api-srv | Linux | assessment_warning | 3 | 0 | 0 | 2 | False | 2026-07-15T16:54:11Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| openvpn-gpandino | Linux | assessment_warning | 2 | 0 | 0 | 2 | False | 2026-07-14T18:00:20Z | 1 error/s reported. The latest 1 error/s are shared in detail. To view all errors, review this log file on the machine: /var/log/azure/Mi... |
| FGARG-v2-2024 | Linux | updates_pending | 1 | 0 | 1 | 0 | False | 2026-07-16T03:09:44Z |  |
| ADDI-2024-srv | Windows | ok | 0 | 0 | 0 | 0 | False | 2026-07-16T02:52:45Z |  |
| datagpfr | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-15T03:53:51Z |  |
| Dominga-HDD-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-16T03:47:21Z |  |
| greenpos-colombia-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-15T03:57:30Z |  |
| middleware-gui-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-15T03:59:42Z |  |
| middleware-integracion-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-15T14:36:07Z |  |
| middleware-staging | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-15T05:01:02Z |  |
| Monitores-Grafana-srv | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-16T03:02:28Z |  |
| UniFi-Controller-VM | Linux | ok | 0 | 0 | 0 | 0 | False | 2026-07-15T04:01:40Z |  |

## Notes

- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.
- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.
- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.
