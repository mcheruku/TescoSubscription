IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistoryCreate]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[PackageExecutionHistoryCreate]

		IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistoryCreate]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[PackageExecutionHistoryCreate] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[PackageExecutionHistoryCreate] not dropped.',16,1)
				
			END
	END
GO

  
CREATE PROCEDURE [tescosubscription].[PackageExecutionHistoryCreate]   
(      
    @PackageID SMALLINT  
     ,@PackageStartTime DATETIME      
)  
  
AS  
  
/*  Author:   Saritha Kommineni  
 Date created: 22 Aug 2011  
 Purpose:     To insert PackageExecution details into [tescosubscription].[PackageExecutionHistory] table  
 Behaviour:    
 Usage:     
 Called by:  SSIS PACKAGE RenewCustomerSubscriptions.dtsx  
 WarmUP Script: Execute [tescosubscription].[PackageExecutionHistoryCreate] 1,'2011-10-10 12:34:56'  
  
--Modifications History--  
 Changed On      Changed By      Defect Ref          Change Description  
 28-09-2011		  Thulasi R                          Renamed sp to PackageExecutionHistoryCreate from PackageExecutionHistorysave  
  
   
*/  
  
BEGIN  
  
 SET NOCOUNT ON;  
  
  INSERT INTO [tescosubscription].[PackageExecutionHistory]            
   (  
    [PackageID]  
      ,[PackageStartTime]  
             ) 
	OUTPUT inserted.PackageExecutionHistoryID        
    VALUES   
           (  
              @PackageID
             ,@PackageStartTime                 
		   ) 


End
  
  
 GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[PackageExecutionHistoryCreate]  TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistoryCreate]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[PackageExecutionHistoryCreate] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[PackageExecutionHistoryCreate] not created.',16,1)
		
	END
GO





 
  



