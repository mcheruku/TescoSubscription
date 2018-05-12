/*

	Author:			ROBIN JOHN
	Date created:	05 Dec 2012
	Purpose:		Rollback Table [tescosubscription].[PaymentInstallment]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PaymentInstallment]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[PaymentInstallment]

		IF OBJECT_ID(N'[tescosubscription].[PaymentInstallment]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[PaymentInstallment] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[PaymentInstallment] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [tescosubscription].[PaymentInstallment] does not exist.'
	END
GO
