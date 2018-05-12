/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Purpose:		Rollback Foreign Key [tescosubscription].[FK_CustomerSubscription_StatusMaster_PaymentProcessStatus]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerSubscription_StatusMaster_PaymentProcessStatus]') 
	 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]'))
	BEGIN

		ALTER TABLE [tescosubscription].[CustomerSubscription] DROP CONSTRAINT [FK_CustomerSubscription_StatusMaster_PaymentProcessStatus]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerSubscription_StatusMaster_PaymentProcessStatus]') 
		 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerSubscription]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [tescosubscription].[FK_CustomerSubscription_StatusMaster_PaymentProcessStatus] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [tescosubscription].[FK_CustomerSubscription_StatusMaster_PaymentProcessStatus] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [tescosubscription].[FK_CustomerSubscription_StatusMaster_PaymentProcessStatus] does not exist.'
	END
GO
