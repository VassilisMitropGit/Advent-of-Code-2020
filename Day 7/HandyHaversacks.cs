//used hints for Part 1 from the respective reddit thread:
//https://www.reddit.com/r/adventofcode/comments/k8a31f/2020_day_07_solutions/?sort=confidence

using System;
using System.Text.RegularExpressions;
using System.Linq;
using System.Collections.Generic;
using System.Collections;
using static System.Text.RegularExpressions.RegexOptions;


namespace Day_7
{
    class Program
    {
        static void Main(string[] args)
        {
            var regulations = System.IO.File.ReadLines(@"HandyHaversacks.txt").
                Select(line => Regex.Match(line, @"(.*) bags contain(?: (\d+ .*?) bags?[,.])*")).
                ToDictionary(
                    i => i.Groups[1].Value,
                    i => i.Groups[2].Captures
                        .Select(j => j.Value.Split(' ', 2))
                        .ToDictionary(
                            k => k[1],
                            k => int.Parse(k[0])
                        )
                );

            //regulations.ToList().ForEach(x => Console.WriteLine(x.Value));
            int bagContained = findPart1Solution(regulations, "shiny gold");
            Console.WriteLine(bagContained);
        }

        public static int findPart1Solution(Dictionary<string, Dictionary<string, int>> regulations, string bagColor){
            bool bagContained(Dictionary<string, int> bags) =>
                bags.ContainsKey(bagColor) || bags.Keys.Any(z => bagContained(regulations[z]));

            return regulations.Values.Count(bagContained);
        }
    }
}