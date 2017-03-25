require_relative 'src/sync_service'

sync_service = SyncService.new('sync_assignment_client_data.csv')

sync_service.sync
