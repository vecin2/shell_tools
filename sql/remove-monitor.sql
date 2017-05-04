delete from FR_MONITOR where REPOSITORY_PATH ='AddCoreChannelsReportingFacts.Implementation.Monitors.InteractionSummaryFactMonitor';
delete from EVA_DYNAMIC_VERB_LIST where ID = @EDVL.StartInteractionSummaryFactMonitor;
