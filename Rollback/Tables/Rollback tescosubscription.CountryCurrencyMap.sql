/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Purpose:		Rollback Table [tescosubscription].[CountryCurrencyMap]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyMap]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[CountryCurrencyMap]

		IF OBJECT_ID(N'[tescosubscription].[CountryCurrencyMap]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[CountryCurrencyMap] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[CountryCurrencyMap] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [tescosubscription].[CountryCurrencyMap] does not exist.'
	END
GO
