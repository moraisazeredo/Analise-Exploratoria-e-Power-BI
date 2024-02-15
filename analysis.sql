-- 1)Qual é a média de sono para pessoas com insomnia?
SELECT AVG(T1."Age") 
FROM sleep_health T1
WHERE T1."Sleep Disorder" = 'Insomnia'


-- 2) Qual a ocupação mais comum entre pessoas com boa qualidade de sono? 
SELECT T1."Occupation", COUNT(*) contagem_de_pessoas
FROM sleep_health T1
WHERE T1."Sleep Duration" > 7 
GROUP BY T1."Occupation" 
LIMIT 1
 
 
-- 3) Existe uma correlação entre o nível de stress e qualidade de sono? 
SELECT CORR(T1."Stress Level", T1."Quality of Sleep")
FROM sleep_health T1


-- 4) Qual é a média de passos diários para pessoas com diferentes categorias de IMC? 
SELECT T1."BMI Category", AVG(T1."Daily Steps")
FROM sleep_health T1
GROUP BY T1."BMI Category" 


-- 5) Quais são as três ocupações com a maior média de qualidade de sono e qual é essa média para cada uma delas? 
WITH occupations AS (
	SELECT T1."Occupation" AS ocupacao, AVG(T1."Quality of Sleep") AS media_sleep
	FROM sleep_health T1
	GROUP BY T1."Occupation"
)
SELECT ocupacao, media_sleep
FROM occupations 
ORDER BY media_sleep DESC
LIMIT 3


-- 6) Quantas pessoas tem uma qualidade de sono acima da média geral 
SELECT COUNT(*)
FROM sleep_health T1
WHERE ("Quality of Sleep") > (
	SELECT AVG("Quality of Sleep")
	FROM sleep_health
)


-- 7) Qual é a média de idade das pessoas que têm uma qualidade de sono acima da média para sua ocupação? 
WITH occupation_sleep AS (
	SELECT "Occupation", AVG("Quality of Sleep") AS avg_sleep
	FROM sleep_health
	GROUP BY "Occupation"
)
SELECT AVG(T1."Age")
FROM sleep_health T1
WHERE "Quality of Sleep" > (
	SELECT avg_sleep
	FROM occupation_sleep T2
	WHERE T1."Occupation" = T2."Occupation"
)
