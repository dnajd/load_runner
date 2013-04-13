require "load_runner/version"

module LoadRunner

	class Queue
		attr_accessor :failures
		
		def initialize(logger = nil)

			# logger
			if logger!=nil
				@logger = logger
			end

			# setup
			@threads = []
			@transactions = 0
			@num_threads = 1
			@failures = 0
		end

		def load(num_threads=1, &work)
			@num_threads = num_threads
			@work = work  # save work for new threads

			# create threads
			num_threads.times do ||

				# do work
				create_thread

				# log
				if @logger!=nil
	    			@logger.debug "action=create|name=thread"
	    		end
		  	end
		end

		def run()
			@start_time = Time.now
			start_all
			wait_until_finished
		end

		def run_and_stagger(max_sleep=10)
			@start_time = Time.now
			start_all { rand_sleep(max_sleep) }
			wait_until_finished
		end

		def run_for_duration(num_seconds, max_sleep=0)
			@start_time = Time.now	

			# keep them running
			to_time = Time.now + num_seconds

			# log
			if @logger!=nil
				@logger.debug "action=run_for_durration|until=#{to_time}"
			end

			# duration
			while (Time.now <= to_time)
				@threads.each do |t| 

					# restart threads
					if (t.status=="sleep")
						rand_sleep(max_sleep)
						t.run
					end	

					if (t.status==false or t.status == nil)
						@transactions += 1
						@threads.delete t
						thread = create_thread
						rand_sleep(max_sleep) 
						thread.run

						# log
						if @logger!=nil
							@logger.debug "thread_count=#{@threads.count}"
						end
					end
				end
			end
			wait_until_finished()
		end

		private

		def create_thread()
		  	thread = Thread.new do ||
		  		Thread.stop
		  		@work.call
		  	end
		  	@threads << thread
		  	return thread
		end

		def start_all(&block)
			@threads.each do |t| 
				
				# pausing block?
				block

				# log
				if @logger!=nil
					@logger.debug "action=start|name=thread"
				end

				# run thread
				t.run
			end
		end

		# wait for threads to complete
		def wait_until_finished()
			@threads.each do |t| 
				if (t.status=="run")
					t.join;  # wait to finish

					# log
					if @logger!=nil
						@logger.debug "action=stop|name=thread"
					end
				end
			end

			# log
			if @logger!=nil
				@logger.debug "transactions=#{@transactions}|threads=#{@num_threads}|failures=#{@failures}|duration=#{Time.now - @start_time}"
			end
		end

		# random sleep
		def rand_sleep(max_sleep=10)
			if max_sleep > 0
				time_to_sleep = rand(0)/max_sleep
				sleep(time_to_sleep)
			end
		end
	end
end