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

            Dictionary<string, int> bags = new Dictionary<string, int>();
            var regulations = System.IO.File.ReadLines(@"HandyHaversacks.txt").
                ToDictionary(
                    line => Regex.Match(line, @"^(\w+ \w+)").Groups[1].Value,
                    line => line.Contains("no other bags.")
                        ? Console.WriteLine("zonk!")
                        : Console.WriteLine("got him")
                );

            regulations.ToList().ForEach(x => Console.WriteLine(x.Key));
        }
    }
}
