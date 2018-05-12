/*

	Author:			Saritha K
	Date created:	06-Jan-2012
	Purpose:		Rollback Foreign Key [tescosubscription].[FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID]') 
	 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponse]'))
	BEGIN

		ALTER TABLE [tescosubscription].[CustomerPaymentHistoryResponse] DROP CONSTRAINT [FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID]') 
		 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponse]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [tescosubscription].[FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [tescosubscription].[FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [tescosubscription].[FK_CustomerPaymentHistoryResponse_CustomerPaymentHistory_CustomerPaymentHistoryID] does not exist.'
	END
GO
