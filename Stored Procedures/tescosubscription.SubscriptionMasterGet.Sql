IF OBJECT_ID(N'[tescosubscription].[SubscriptionMasterGet]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionMasterGet]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionMasterGet]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionMasterGet] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionMasterGet] not dropped.',16,1)
				
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[SubscriptionMasterGet] 
AS

/*

	Author:			Praneeth Raj
	Date created:	26 July 2011
	Purpose:		To get subscriptions master data
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	Execute [tescosubscription].[SubscriptionMasterGet] 

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	26-July-2011	Sheshgiri Balgi		<TFS no.>	Changed	Return Type to xml
	28-July-2011	Ravi Paladugu					Changed Xml element name from SubscriptionTypeDetail to SubscriptionMasterDetail

*/

BEGIN

			SET NOCOUNT ON	
		
			SELECT [SubscriptionID]   'SubscriptionID',
				   [SubscriptionName] 'SubscriptionName'   
		    FROM   [tescosubscription].[SubscriptionMaster] 
			ORDER BY [SubscriptionName] 
			FOR XML PATH('SubscriptionMasterDetail'),TYPE,root('SubscriptionMasterDetails')	


END

GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionMasterGet]  TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionMasterGet]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionMasterGet] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionMasterGet] not created.',16,1)
		
	END
GO






