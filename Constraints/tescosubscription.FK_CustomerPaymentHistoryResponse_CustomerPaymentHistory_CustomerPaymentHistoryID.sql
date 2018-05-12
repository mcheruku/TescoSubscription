/*

	Author:			Saritha K
	Date created:	06-JAN-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[CustomerPaymentHistory] and [tescosubscription].[CustomerPaymentHistoryResponse]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponse]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerPaymentHistoryResponse]  WITH CHECK ADD  CONSTRAINT [FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID] FOREIGN KEY([CustomerPaymentHistoryID])
				REFERENCES [tescosubscription].[CustomerPaymentHistory] ([CustomerPaymentHistoryID])

				ALTER TABLE [tescosubscription].[CustomerPaymentHistoryResponse] CHECK CONSTRAINT [FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[CustomerPaymentHistory]/[tescosubscription].[CustomerPaymentHistoryResponse] does not exist.',16,1)
	END
GO
