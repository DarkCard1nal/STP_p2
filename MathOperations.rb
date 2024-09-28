# frozen_string_literal: true

require_relative 'Constants'

# Static class that defines mathematical operations and their priority receives operations from the specified file
class MathOperations # rubocop:disable Metrics/ClassLength
	# rubocop:disable Style/ClassVars
	@@MathOperations = [%w[+ -], %w[* / %], '^']
	@@PrioritySticksOpen = %w'( ['
	@@PrioritySticksClose = %w') ]'
	@@Regexps = {
		Op: Regexp.union(@@MathOperations.flatten),
		So: Regexp.union(@@PrioritySticksOpen),
		Sc: Regexp.union(@@PrioritySticksClose),
		OpSo: Regexp.union(@@MathOperations.flatten + @@PrioritySticksOpen),
		OpSc: Regexp.union(@@MathOperations.flatten + @@PrioritySticksClose),
		SoSc: Regexp.union(@@PrioritySticksOpen + @@PrioritySticksClose),
		All: Regexp.union(@@MathOperations.flatten + @@PrioritySticksOpen + @@PrioritySticksClose)
	}
	# rubocop:enable Style/ClassVars

	def initialize
		raise NotImplementedError
	end

	# The method determines the priority of the operation, where 0 is low priority (0 and above is the index in
	# the MathOperations array), if -1 is opening the wishbone, if -2 is closing the wishbone,
	# if it is an unknown operation it is nil
	def self.OperationPriority(input)
		index = @@PrioritySticksOpen.index(input)
		if index.nil?
			index = @@PrioritySticksClose.index(input)
			if index.nil?
				@@MathOperations.each_with_index do |array, indexx|
					return indexx if array.include?(input)
				end
			else
				index = -2
			end
		else
			index = -1
		end

		index
	end

	# Formats a string with a mathematical formula to the desired look, removes unnecessary elements
	def self.ReplaceWithSpaces(input)
		input = PreprocessInputInReplaceWithSpaces(input)
		lastIndex = 0
		input.reverse!
		input.gsub!(@@Regexps[:Op]) do |chr|
			index = input.index(chr, lastIndex)
			right, left = FindNeighborsInReplaceWithSpaces(input, index, chr)
			lastIndex = index

			ProcessingMathOperationsInReplaceWithSpaces(chr, input.length - 1 - index, left, right)
		end

		input.reverse!.gsub!(@@Regexps[:SoSc]) do |chr|
			" #{chr} "
		end

		input = PostprocessInputInReplaceWithSpaces(input)
	end

	def self.UpdateMathOperationsFromFile(filePath)
		unless File.exist?(filePath)
			puts Constants::FILE_NOT_FOUND
			return
		end

		unless File.readable?(filePath)
			puts Constants::FILE_NOT_READABLE
			return
		end

		lines = File.readlines(filePath)
		if lines.length < 3
			puts Constants::FILE_BROKEN
			return
		end

		groups = lines[0].split(',').map(&:split)

		# rubocop:disable Style/ClassVars
		@@MathOperations = groups
		@@PrioritySticksOpen = lines[1].split
		@@PrioritySticksClose = lines[2].split
		# rubocop:enable Style/ClassVars
	end

	# Method checks the line with the expression for division by 0
	def self.IsDivisionByZero(input)
		input = input.gsub(/\s+/, '')

		input.gsub!(@@Regexps[:All]) { |chr| chr == '/' ? chr : '' }

		isDivisionByZero = input.include?('/0')

		puts(Constants::DIVISION_BY_ZERO) if isDivisionByZero

		isDivisionByZero
	end

	# Method for removing MathOperations characters at the beginning and end of a string,
	# does not remove the '-' simovol at the beginning if it is part of a negative value
	def self.StripMathOperations(input)
		regex = Regexp.union(@@MathOperations.flatten)

		input.sub!(/\A(?:#{regex})+/) do |match|
			match.include?('-') && input[match.length] !~ regex ? '-' : ''
		end

		input.sub!(/(?:#{regex})+\z/, '')

		input
	end

	# rubocop:disable all

	# Method to handle mathematical operations in a string, adding spaces around operators depending 
	# on their position relative to neighboring characters. The method takes the current operator, 
	# its index, and the characters to its left and right to determine whether spaces should be added.
	def self.ProcessingMathOperationsInReplaceWithSpaces(chr, index, left, right)
		if index.positive?
			# Handling the '-' character as part of a negative number
			if chr == '-' 
				if (left =~ @@Regexps[:OpSo] && right !~ @@Regexps[:All]) ||
							(left =~ @@Regexps[:Op] && right =~ @@Regexps[:So])
					return "#{chr} "
				end
			end
			# Handling of mathematical operations
			if (left !~ @@Regexps[:All] && (right !~ @@Regexps[:OpSc]) || right == '-') || 
							left =~ @@Regexps[:Sc]
				chr = " #{chr} "
			else
				chr = ''
			end
		end

		chr
	end
	# rubocop:enable all

	# String preprocessing: whitespace removal and cleanup for method ReplaceWithSpaces
	def self.PreprocessInputInReplaceWithSpaces(input)
		StripMathOperations(input.gsub(/\s+/, ''))
	end

	# String post-processing: removing extra spaces for a method ReplaceWithSpaces
	def self.PostprocessInputInReplaceWithSpaces(input)
		input.gsub(/\s+/, ' ').strip
	end

	# Search for characters to the left and right of the current character for a method ReplaceWithSpaces
	def self.FindNeighborsInReplaceWithSpaces(input, index, chr)
		left = nil
		right = nil

		unless index.nil?
			left = input[index - 1]
			right = input[index + chr.length] if (index + chr.length) < input.length
		end

		[left, right]
	end

	private_class_method :StripMathOperations
	private_class_method :ProcessingMathOperationsInReplaceWithSpaces
	private_class_method :PreprocessInputInReplaceWithSpaces
	private_class_method :PostprocessInputInReplaceWithSpaces
	private_class_method :FindNeighborsInReplaceWithSpaces
end
