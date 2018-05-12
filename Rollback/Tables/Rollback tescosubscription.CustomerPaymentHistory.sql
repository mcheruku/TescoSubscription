/*

	Author:			Robin
	Date created:	14-April-2014
	Purpose:		Rollback Table [tescosubscription].[CustomerPaymentHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/


--------------- Drop column IsPreAuth ------------------------

IF  EXISTS(SELECT 1 FROM  information_schema.columns      
				WHERE table_schema      = 'TescoSubscription'
				AND table_name          = 'CustomerPaymentHistory'
				AND column_name         = 'IsPreAuth') 
BEGIN     
    ALTER TABLE [tescosubscription].[CustomerPaymentHistory] DROP CONSTRAINT [DF_CustomerPaymentHistory_IsPreAuth]
	ALTER TABLE  [tescosubscription].[CustomerPaymentHistory] DROP COLUMN IsPreAuth 

		PRINT 'Column tescosubscription.CustomerPaymentHistory.IsPreAuth Droppped'
END
GO
