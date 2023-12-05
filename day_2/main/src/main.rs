fn main() {
    let input = std::fs::read_to_string("../input.txt").unwrap();

    // part 1
    let sum = input.lines().fold(0, |acc, line| {
        let (id, game_str) = line.split_once(':').unwrap();

        if game_str[1..].split(';').all(|demo| {
            demo.split(',').all(|cube| {
                let val = cube.split_ascii_whitespace().nth(0).unwrap().parse::<u32>().unwrap();
                match cube.split_ascii_whitespace().nth(1).unwrap() {
                    "red" => val <= 12,
                    "green" => val <= 13,
                    _ => val <= 14 
                }
            })
        }) {
            acc + id[5..].parse::<u32>().unwrap()
        } else {
            acc
        }
    });
    println!("{sum}");

    // part 2

    let sum: u32= input.lines().map(|line| {
        let (_, game_str) = line.split_once(':').unwrap();

        struct Colors {
            reds: u32,
            greens: u32,
            blues: u32
        }

        impl From<(u32, u32, u32)> for Colors {
            fn from(value: (u32, u32, u32)) -> Self {
                Colors { reds: value.0, greens: value.1, blues: value.2 }
            }
        }

        impl Colors {
            fn supremum(self, other: Self) -> Self {
                Colors::from((
                    std::cmp::max(self.reds, other.reds),
                    std::cmp::max(self.greens, other.greens),
                    std::cmp::max(self.blues, other.blues)
                ))
            }
            fn insert_red_if_max(mut self, value: u32) -> Self {
                self.reds = std::cmp::max(self.reds, value);
                self
            }

            fn insert_green_if_max(mut self, value: u32) -> Self {
                self.greens = std::cmp::max(self.greens, value);
                self
            }

            fn insert_blue_if_max(mut self, value: u32) -> Self {
                self.blues = std::cmp::max(self.blues, value);
                self
            }

            fn power(&self) -> u32 {
                self.reds * self.greens * self.blues
            }
        }

        game_str[1..].split(';').fold(Colors::from((0, 0, 0)), |acc, demo| {
            acc.supremum(
                demo.split(',').fold(Colors::from((0, 0, 0)), |acc, cube| {
                    let val = cube.split_ascii_whitespace().nth(0).unwrap().parse::<u32>().unwrap();
                    match cube.split_ascii_whitespace().nth(1).unwrap() {
                        "red" => acc.insert_red_if_max(val),
                        "green" => acc.insert_green_if_max(val),
                        _ => acc.insert_blue_if_max(val)
                    }
                })
            )
        }).power()
    }).sum();
    println!("{sum}");
}
