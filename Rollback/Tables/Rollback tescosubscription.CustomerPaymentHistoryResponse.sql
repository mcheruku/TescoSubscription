/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Purpose:		Rollback Table [tescosubscription].[CustomerPaymentHistoryResponse]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponse]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[CustomerPaymentHistoryResponse]

		IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponse]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[CustomerPaymentHistoryResponse] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[CustomerPaymentHistoryResponse] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table	.[CustomerPaymentHistoryResponse] does not exist.'
	END
GO
