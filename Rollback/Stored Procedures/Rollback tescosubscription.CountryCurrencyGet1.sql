/*

	Author:			Robin
	Date created:	05-Dec-2012
	Purpose:		Rollback Procedure [tescosubscription].[CountryCurrencyGet1]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyGet1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CountryCurrencyGet1]

		IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyGet1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CountryCurrencyGet1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CountryCurrencyGet1] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[CountryCurrencyGet1] does not exist.'
	END
GO
