/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Purpose:		Rollback Table [tescosubscription].[CustomerSubscription]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	16 Jan 2013     Robin		<TFS no.>		added rollbacks for two new coloumns
	27 Jun 2013     Robin                       added rollback for the new coloumn for D5 Release

*/


--------------- Remove column [NextPaymentDate] ------------------------

IF EXISTS(SELECT 1 FROM information_schema.columns      
				WHERE TABLE_SCHEMA      = 'tescosubscription'
				AND TABLE_NAME			= 'CustomerSubscription'
				AND COLUMN_NAME         = 'NextPaymentDate'
               
) 
BEGIN  
          
	ALTER TABLE [tescosubscription].[CustomerSubscription] DROP COLUMN NextPaymentDate 
     
		PRINT 'Column tescosubscription.CustomerSubscription.NextPaymentDate is Deleted'
END
GO


