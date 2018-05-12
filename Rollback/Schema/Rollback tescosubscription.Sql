/*

	Author:			Saritha K
	Date created:	27-Jul-2011
	Purpose:		Rollback Schema [tescosubscription]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE [schema_name] = 'tescosubscription')
	BEGIN

		DROP SCHEMA [tescosubscription]

		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE [schema_name] = 'tescosubscription')
			BEGIN
				PRINT 'SUCCESS - Schema [tescosubscription] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Schema [tescosubscription] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Schema [tescosubscription] does not exist.'
	END
GO
