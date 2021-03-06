IF OBJECT_ID(N'[tescosubscription].[PersonalizedSavingsConfigGet]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[PersonalizedSavingsConfigGet] 

		IF OBJECT_ID(N'[tescosubscription].[PersonalizedSavingsConfigGet]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[PersonalizedSavingsConfigGet] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[PersonalizedSavingsConfigGet] not dropped.',16,1)
				
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[PersonalizedSavingsConfigGet] 
AS

/*

	Author:			Deepmala Trivedi
	Date created:	08 Aug 2013
	Purpose:		To get all the Country Currencies
	Behaviour:		How does this procedure actually work
	Usage:			Hourly/Often
	Called by:		<Scheduler>
	WarmUP Script:	NA    
*/

BEGIN

	   SET NOCOUNT ON		
	
	  SELECT [SettingName],
              [SettingValue]
	   FROM   [TescoSubscription].[ConfigurationSettings] (NOLOCK)
	   Where SettingName in ('IsPersonalizeSaving','PersonalizedSavingsAmount')
END


GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[PersonalizedSavingsConfigGet]   TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[PersonalizedSavingsConfigGet]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[PersonalizedSavingsConfigGet] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[PersonalizedSavingsConfigGet] not created.',16,1)
		
	END
GO

