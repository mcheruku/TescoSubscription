IF OBJECT_ID(N'[tescosubscription].[SubscriptionBusinessGet]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[SubscriptionBusinessGet] 

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionBusinessGet]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionBusinessGet]  dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionBusinessGet]  not dropped.',16,1)
				
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[SubscriptionBusinessGet]  
AS

/*

	Author:			Praneeth Raj
	Date created:	26 July 2011
	Purpose:		To get list of businesses
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<BOA>
	WarmUP Script:	Execute [tescosubscription].[SubscriptionBusinessGet]  

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	26-July-2011	Sheshgiri Balgi		<TFS no.>	Changed	Return Type to xml


*/



BEGIN

	SET NOCOUNT ON			
			SELECT  [BusinessID]   'BusinessID',
				    [BusinessName] 'BusinessName'    
			FROM    [tescosubscription].[BusinessMaster]	
		    FOR XML PATH('BusinessDetail'),TYPE,root('BusinessDetails')
END

GO


--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[SubscriptionBusinessGet]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[SubscriptionBusinessGet]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionBusinessGet]  created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionBusinessGet]  not created.',16,1)
		
	END
GO

