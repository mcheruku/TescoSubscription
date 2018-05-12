/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Purpose:		Rollback Table [tescosubscription].[PaymentModeMaster]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PaymentModeMaster]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[PaymentModeMaster]

		IF OBJECT_ID(N'[tescosubscription].[PaymentModeMaster]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[PaymentModeMaster] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[PaymentModeMaster] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [tescosubscription].[PaymentModeMaster] does not exist.'
	END
GO
