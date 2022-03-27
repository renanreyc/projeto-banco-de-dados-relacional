SELECT
	d.name,
	ROUND(SUM((a.hours * 150)+((a.hours * 15)*w.bonus)*.1), 1) as salary
FROM doctors d, attendances a, work_shifts w
WHERE
	d.id=a.id_doctor
    AND w.id=a.id_work_shift
GROUP BY d.name
ORDER BY salary DESC;