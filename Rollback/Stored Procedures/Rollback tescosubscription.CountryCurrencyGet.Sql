/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Purpose:		Rollback Procedure [tescosubscription].[CountryCurrencyGet]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	06 Dec 2012 	Robin		<TFS no.>		Added a new coloumn to SP (country currency) consumed by <BOA>

*/
IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CountryCurrencyGet]

		IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CountryCurrencyGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CountryCurrencyGet] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[CountryCurrencyGet] does not exist.'
	END
GO
