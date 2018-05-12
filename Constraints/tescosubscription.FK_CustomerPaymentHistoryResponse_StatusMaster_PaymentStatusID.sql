/*

	Author:			Saritha k
	Date created:	06-Jan-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[StatusMaster] and [tescosubscription].[CustomerPaymentHistoryResponse]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[StatusMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponse]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentHistoryResponse_StatusMaster_PaymentStatusID')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerPaymentHistoryResponse]  WITH CHECK ADD  CONSTRAINT [FK_CustomerPaymentHistoryResponse_StatusMaster_PaymentStatusID] FOREIGN KEY([PaymentStatusID])
				REFERENCES [tescosubscription].[StatusMaster] ([StatusId])

				ALTER TABLE [tescosubscription].[CustomerPaymentHistoryResponse] CHECK CONSTRAINT [FK_CustomerPaymentHistoryResponse_StatusMaster_PaymentStatusID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentHistoryResponse_StatusMaster_PaymentStatusID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerPaymentHistoryResponse_StatusMaster_PaymentStatusID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerPaymentHistoryResponse_StatusMaster_PaymentStatusID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerPaymentHistoryResponse_StatusMaster_PaymentStatusID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[StatusMaster]/[tescosubscription].[CustomerPaymentHistoryResponse] does not exist.',16,1)
	END
GO
