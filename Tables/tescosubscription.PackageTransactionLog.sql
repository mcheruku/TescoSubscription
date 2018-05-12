/*

	Author:			Saritha Kommineni
	Date created:	23-Aug-2011
	Table Type:		Transactional
	Purpose:		To hold payment logs
	Fillfactor:		<Default 90% for Transactional, 100% for Reference>
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[packageTransactionLog]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[packageTransactionLog]
      
	END

IF OBJECT_ID(N'[tescosubscription].[packageTransactionLog]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[packageTransactionLog] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[packageTransactionLog] not dropped.',16,1)
			END

GO
