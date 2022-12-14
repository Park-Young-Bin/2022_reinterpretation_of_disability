# 참고
memory.size(max = TRUE)    # OS에서 얻은 최대 메모리 크기 = OS로부터 R이 사용 가능한 메모리
memory.size(max = FALSE)   # 현재 사용중인 메모리 크기
memory.limit(size = NA)    # 컴퓨터의 최대 메모리 한계치 
memory.limit(size = 50000) # 컴퓨터의 최대 메모리 한계치 약 49GB로 높이기

# 참고 자료
# 결측치 확인: https://velog.io/@suzin/R-%EB%8D%B0%EC%9D%B4%ED%84%B0-%ED%83%90%EC%83%89-3.-Missing-Value%EA%B2%B0%EC%B8%A1%EC%B9%98-NA
# 날짜 데이터 다루기: https://kuduz.tistory.com/1201

# 필요한 패키지 불러오기
library(readxl)
library(dplyr)
library(reshape2)
library(ggplot2)
library(openxlsx)

# 데이터 불러오기
df_2019_1 <- read_excel('C:/Users/user/Desktop/Python/NRC(콜택시)/data/장애인콜시스템(19.01.01~19.08.31).xlsx', na="NA")
df_2019_2 <- read_excel('C:/Users/user/Desktop/Python/NRC(콜택시)/data/장애인콜시스템(19.09.01~19.12.31).xlsx', na="NA")
df_2020_1 <- read_excel('C:/Users/user/Desktop/Python/NRC(콜택시)/data/장애인콜시스템(20.01.01~20.08.31).xlsx', na="NA")
df_2020_2 <- read_excel('C:/Users/user/Desktop/Python/NRC(콜택시)/data/장애인콜시스템(20.09.01~20.12.31).xlsx', na="NA")
df_2021_1 <- read_excel('C:/Users/user/Desktop/Python/NRC(콜택시)/data/장애인콜시스템(21.01.01~21.08.31).xlsx', na="NA")
df_2021_2 <- read_excel('C:/Users/user/Desktop/Python/NRC(콜택시)/data/장애인콜시스템(21.09.01~21.12.31).xlsx', na="NA")
df_2022_1 <- read_excel('C:/Users/user/Desktop/Python/NRC(콜택시)/data/장애인콜시스템(22.01.01~22.08.20).xlsx', na="NA")

# 년도별 데이터 결합(rbind)
df_2019 <- rbind(df_2019_1, df_2019_2)
df_2020 <- rbind(df_2020_1, df_2020_2)
df_2021 <- rbind(df_2021_1, df_2021_2)

# 결측치(NA) 개수 확인
sum(is.na(df_2019)) # 147
colSums(is.na(df_2019))

sum(is.na(df_2020)) # 151
colSums(is.na(df_2020))

sum(is.na(df_2021)) # 304
colSums(is.na(df_2021))

sum(is.na(df_2022_1)) # 548
colSums(is.na(df_2022_1))

# 결측치가 있는 행(결측치를 1개라도 포함하는 행) 개수
sum(!complete.cases(df_2019)) # 184
sum(!complete.cases(df_2020)) # 102
sum(!complete.cases(df_2021)) # 126
sum(!complete.cases(df_2022_1)) # 244

# 결측치를 갖고 있는 행 모두 제거 (na.omit() 함수와 같은 기능)
df_2019_rm_na <- df_2019[complete.cases(df_2019),]
df_2020_rm_na <- df_2020[complete.cases(df_2020),]
df_2021_rm_na <- df_2021[complete.cases(df_2021),]
df_2022_rm_na <- df_2022_1[complete.cases(df_2022_1),]

# 날짜형식 칼럼(예정일시, 배차일시, 승차일시) 정제
# 2019년
df_2019_rm_na$예정일시 <- gsub("오전 12:", "0:", df_2019_rm_na$예정일시)
df_2019_rm_na$예정일시 <- gsub("오전 ", "", df_2019_rm_na$예정일시)
df_2019_rm_na$예정일시 <- gsub("오후 12:", "12:", df_2019_rm_na$예정일시)
df_2019_rm_na$예정일시 <- gsub("오후 1:", "13:", df_2019_rm_na$예정일시)
df_2019_rm_na$예정일시 <- gsub("오후 2:", "14:", df_2019_rm_na$예정일시)
df_2019_rm_na$예정일시 <- gsub("오후 3:", "15:", df_2019_rm_na$예정일시)
df_2019_rm_na$예정일시 <- gsub("오후 4:", "16:", df_2019_rm_na$예정일시)
df_2019_rm_na$예정일시 <- gsub("오후 5:", "17:", df_2019_rm_na$예정일시)
df_2019_rm_na$예정일시 <- gsub("오후 6:", "18:", df_2019_rm_na$예정일시)
df_2019_rm_na$예정일시 <- gsub("오후 7:", "19:", df_2019_rm_na$예정일시)
df_2019_rm_na$예정일시 <- gsub("오후 8:", "20:", df_2019_rm_na$예정일시)
df_2019_rm_na$예정일시 <- gsub("오후 9:", "21:", df_2019_rm_na$예정일시)
df_2019_rm_na$예정일시 <- gsub("오후 10:", "22:", df_2019_rm_na$예정일시)
df_2019_rm_na$예정일시 <- gsub("오후 11:", "23:", df_2019_rm_na$예정일시)

df_2019_rm_na$배차일시 <- gsub("오전 12:", "0:", df_2019_rm_na$배차일시)
df_2019_rm_na$배차일시 <- gsub("오전 ", "", df_2019_rm_na$배차일시)
df_2019_rm_na$배차일시 <- gsub("오후 12:", "12:", df_2019_rm_na$배차일시)
df_2019_rm_na$배차일시 <- gsub("오후 1:", "13:", df_2019_rm_na$배차일시)
df_2019_rm_na$배차일시 <- gsub("오후 2:", "14:", df_2019_rm_na$배차일시)
df_2019_rm_na$배차일시 <- gsub("오후 3:", "15:", df_2019_rm_na$배차일시)
df_2019_rm_na$배차일시 <- gsub("오후 4:", "16:", df_2019_rm_na$배차일시)
df_2019_rm_na$배차일시 <- gsub("오후 5:", "17:", df_2019_rm_na$배차일시)
df_2019_rm_na$배차일시 <- gsub("오후 6:", "18:", df_2019_rm_na$배차일시)
df_2019_rm_na$배차일시 <- gsub("오후 7:", "19:", df_2019_rm_na$배차일시)
df_2019_rm_na$배차일시 <- gsub("오후 8:", "20:", df_2019_rm_na$배차일시)
df_2019_rm_na$배차일시 <- gsub("오후 9:", "21:", df_2019_rm_na$배차일시)
df_2019_rm_na$배차일시 <- gsub("오후 10:", "22:", df_2019_rm_na$배차일시)
df_2019_rm_na$배차일시 <- gsub("오후 11:", "23:", df_2019_rm_na$배차일시)

df_2019_rm_na$승차일시 <- gsub("오전 12:", "0:", df_2019_rm_na$승차일시)
df_2019_rm_na$승차일시 <- gsub("오전 ", "", df_2019_rm_na$승차일시)
df_2019_rm_na$승차일시 <- gsub("오후 12:", "12:", df_2019_rm_na$승차일시)
df_2019_rm_na$승차일시 <- gsub("오후 1:", "13:", df_2019_rm_na$승차일시)
df_2019_rm_na$승차일시 <- gsub("오후 2:", "14:", df_2019_rm_na$승차일시)
df_2019_rm_na$승차일시 <- gsub("오후 3:", "15:", df_2019_rm_na$승차일시)
df_2019_rm_na$승차일시 <- gsub("오후 4:", "16:", df_2019_rm_na$승차일시)
df_2019_rm_na$승차일시 <- gsub("오후 5:", "17:", df_2019_rm_na$승차일시)
df_2019_rm_na$승차일시 <- gsub("오후 6:", "18:", df_2019_rm_na$승차일시)
df_2019_rm_na$승차일시 <- gsub("오후 7:", "19:", df_2019_rm_na$승차일시)
df_2019_rm_na$승차일시 <- gsub("오후 8:", "20:", df_2019_rm_na$승차일시)
df_2019_rm_na$승차일시 <- gsub("오후 9:", "21:", df_2019_rm_na$승차일시)
df_2019_rm_na$승차일시 <- gsub("오후 10:", "22:", df_2019_rm_na$승차일시)
df_2019_rm_na$승차일시 <- gsub("오후 11:", "23:", df_2019_rm_na$승차일시)

# 2020년
df_2020_rm_na$예정일시 <- gsub("오전 12:", "0:", df_2020_rm_na$예정일시)
df_2020_rm_na$예정일시 <- gsub("오전 ", "", df_2020_rm_na$예정일시)
df_2020_rm_na$예정일시 <- gsub("오후 12:", "12:", df_2020_rm_na$예정일시)
df_2020_rm_na$예정일시 <- gsub("오후 1:", "13:", df_2020_rm_na$예정일시)
df_2020_rm_na$예정일시 <- gsub("오후 2:", "14:", df_2020_rm_na$예정일시)
df_2020_rm_na$예정일시 <- gsub("오후 3:", "15:", df_2020_rm_na$예정일시)
df_2020_rm_na$예정일시 <- gsub("오후 4:", "16:", df_2020_rm_na$예정일시)
df_2020_rm_na$예정일시 <- gsub("오후 5:", "17:", df_2020_rm_na$예정일시)
df_2020_rm_na$예정일시 <- gsub("오후 6:", "18:", df_2020_rm_na$예정일시)
df_2020_rm_na$예정일시 <- gsub("오후 7:", "19:", df_2020_rm_na$예정일시)
df_2020_rm_na$예정일시 <- gsub("오후 8:", "20:", df_2020_rm_na$예정일시)
df_2020_rm_na$예정일시 <- gsub("오후 9:", "21:", df_2020_rm_na$예정일시)
df_2020_rm_na$예정일시 <- gsub("오후 10:", "22:", df_2020_rm_na$예정일시)
df_2020_rm_na$예정일시 <- gsub("오후 11:", "23:", df_2020_rm_na$예정일시)

df_2020_rm_na$배차일시 <- gsub("오전 12:", "0:", df_2020_rm_na$배차일시)
df_2020_rm_na$배차일시 <- gsub("오전 ", "", df_2020_rm_na$배차일시)
df_2020_rm_na$배차일시 <- gsub("오후 12:", "12:", df_2020_rm_na$배차일시)
df_2020_rm_na$배차일시 <- gsub("오후 1:", "13:", df_2020_rm_na$배차일시)
df_2020_rm_na$배차일시 <- gsub("오후 2:", "14:", df_2020_rm_na$배차일시)
df_2020_rm_na$배차일시 <- gsub("오후 3:", "15:", df_2020_rm_na$배차일시)
df_2020_rm_na$배차일시 <- gsub("오후 4:", "16:", df_2020_rm_na$배차일시)
df_2020_rm_na$배차일시 <- gsub("오후 5:", "17:", df_2020_rm_na$배차일시)
df_2020_rm_na$배차일시 <- gsub("오후 6:", "18:", df_2020_rm_na$배차일시)
df_2020_rm_na$배차일시 <- gsub("오후 7:", "19:", df_2020_rm_na$배차일시)
df_2020_rm_na$배차일시 <- gsub("오후 8:", "20:", df_2020_rm_na$배차일시)
df_2020_rm_na$배차일시 <- gsub("오후 9:", "21:", df_2020_rm_na$배차일시)
df_2020_rm_na$배차일시 <- gsub("오후 10:", "22:", df_2020_rm_na$배차일시)
df_2020_rm_na$배차일시 <- gsub("오후 11:", "23:", df_2020_rm_na$배차일시)

df_2020_rm_na$승차일시 <- gsub("오전 12:", "0:", df_2020_rm_na$승차일시)
df_2020_rm_na$승차일시 <- gsub("오전 ", "", df_2020_rm_na$승차일시)
df_2020_rm_na$승차일시 <- gsub("오후 12:", "12:", df_2020_rm_na$승차일시)
df_2020_rm_na$승차일시 <- gsub("오후 1:", "13:", df_2020_rm_na$승차일시)
df_2020_rm_na$승차일시 <- gsub("오후 2:", "14:", df_2020_rm_na$승차일시)
df_2020_rm_na$승차일시 <- gsub("오후 3:", "15:", df_2020_rm_na$승차일시)
df_2020_rm_na$승차일시 <- gsub("오후 4:", "16:", df_2020_rm_na$승차일시)
df_2020_rm_na$승차일시 <- gsub("오후 5:", "17:", df_2020_rm_na$승차일시)
df_2020_rm_na$승차일시 <- gsub("오후 6:", "18:", df_2020_rm_na$승차일시)
df_2020_rm_na$승차일시 <- gsub("오후 7:", "19:", df_2020_rm_na$승차일시)
df_2020_rm_na$승차일시 <- gsub("오후 8:", "20:", df_2020_rm_na$승차일시)
df_2020_rm_na$승차일시 <- gsub("오후 9:", "21:", df_2020_rm_na$승차일시)
df_2020_rm_na$승차일시 <- gsub("오후 10:", "22:", df_2020_rm_na$승차일시)
df_2020_rm_na$승차일시 <- gsub("오후 11:", "23:", df_2020_rm_na$승차일시)

# 2021년
df_2021_rm_na$예정일시 <- gsub("오전 12:", "0:", df_2021_rm_na$예정일시)
df_2021_rm_na$예정일시 <- gsub("오전 ", "", df_2021_rm_na$예정일시)
df_2021_rm_na$예정일시 <- gsub("오후 12:", "12:", df_2021_rm_na$예정일시)
df_2021_rm_na$예정일시 <- gsub("오후 1:", "13:", df_2021_rm_na$예정일시)
df_2021_rm_na$예정일시 <- gsub("오후 2:", "14:", df_2021_rm_na$예정일시)
df_2021_rm_na$예정일시 <- gsub("오후 3:", "15:", df_2021_rm_na$예정일시)
df_2021_rm_na$예정일시 <- gsub("오후 4:", "16:", df_2021_rm_na$예정일시)
df_2021_rm_na$예정일시 <- gsub("오후 5:", "17:", df_2021_rm_na$예정일시)
df_2021_rm_na$예정일시 <- gsub("오후 6:", "18:", df_2021_rm_na$예정일시)
df_2021_rm_na$예정일시 <- gsub("오후 7:", "19:", df_2021_rm_na$예정일시)
df_2021_rm_na$예정일시 <- gsub("오후 8:", "20:", df_2021_rm_na$예정일시)
df_2021_rm_na$예정일시 <- gsub("오후 9:", "21:", df_2021_rm_na$예정일시)
df_2021_rm_na$예정일시 <- gsub("오후 10:", "22:", df_2021_rm_na$예정일시)
df_2021_rm_na$예정일시 <- gsub("오후 11:", "23:", df_2021_rm_na$예정일시)

df_2021_rm_na$배차일시 <- gsub("오전 12:", "0:", df_2021_rm_na$배차일시)
df_2021_rm_na$배차일시 <- gsub("오전 ", "", df_2021_rm_na$배차일시)
df_2021_rm_na$배차일시 <- gsub("오후 12:", "12:", df_2021_rm_na$배차일시)
df_2021_rm_na$배차일시 <- gsub("오후 1:", "13:", df_2021_rm_na$배차일시)
df_2021_rm_na$배차일시 <- gsub("오후 2:", "14:", df_2021_rm_na$배차일시)
df_2021_rm_na$배차일시 <- gsub("오후 3:", "15:", df_2021_rm_na$배차일시)
df_2021_rm_na$배차일시 <- gsub("오후 4:", "16:", df_2021_rm_na$배차일시)
df_2021_rm_na$배차일시 <- gsub("오후 5:", "17:", df_2021_rm_na$배차일시)
df_2021_rm_na$배차일시 <- gsub("오후 6:", "18:", df_2021_rm_na$배차일시)
df_2021_rm_na$배차일시 <- gsub("오후 7:", "19:", df_2021_rm_na$배차일시)
df_2021_rm_na$배차일시 <- gsub("오후 8:", "20:", df_2021_rm_na$배차일시)
df_2021_rm_na$배차일시 <- gsub("오후 9:", "21:", df_2021_rm_na$배차일시)
df_2021_rm_na$배차일시 <- gsub("오후 10:", "22:", df_2021_rm_na$배차일시)
df_2021_rm_na$배차일시 <- gsub("오후 11:", "23:", df_2021_rm_na$배차일시)

df_2021_rm_na$승차일시 <- gsub("오전 12:", "0:", df_2021_rm_na$승차일시)
df_2021_rm_na$승차일시 <- gsub("오전 ", "", df_2021_rm_na$승차일시)
df_2021_rm_na$승차일시 <- gsub("오후 12:", "12:", df_2021_rm_na$승차일시)
df_2021_rm_na$승차일시 <- gsub("오후 1:", "13:", df_2021_rm_na$승차일시)
df_2021_rm_na$승차일시 <- gsub("오후 2:", "14:", df_2021_rm_na$승차일시)
df_2021_rm_na$승차일시 <- gsub("오후 3:", "15:", df_2021_rm_na$승차일시)
df_2021_rm_na$승차일시 <- gsub("오후 4:", "16:", df_2021_rm_na$승차일시)
df_2021_rm_na$승차일시 <- gsub("오후 5:", "17:", df_2021_rm_na$승차일시)
df_2021_rm_na$승차일시 <- gsub("오후 6:", "18:", df_2021_rm_na$승차일시)
df_2021_rm_na$승차일시 <- gsub("오후 7:", "19:", df_2021_rm_na$승차일시)
df_2021_rm_na$승차일시 <- gsub("오후 8:", "20:", df_2021_rm_na$승차일시)
df_2021_rm_na$승차일시 <- gsub("오후 9:", "21:", df_2021_rm_na$승차일시)
df_2021_rm_na$승차일시 <- gsub("오후 10:", "22:", df_2021_rm_na$승차일시)
df_2021_rm_na$승차일시 <- gsub("오후 11:", "23:", df_2021_rm_na$승차일시)

# 2022년
df_2022_rm_na$예정일시 <- gsub("오전 12:", "0:", df_2022_rm_na$예정일시)
df_2022_rm_na$예정일시 <- gsub("오전 ", "", df_2022_rm_na$예정일시)
df_2022_rm_na$예정일시 <- gsub("오후 12:", "12:", df_2022_rm_na$예정일시)
df_2022_rm_na$예정일시 <- gsub("오후 1:", "13:", df_2022_rm_na$예정일시)
df_2022_rm_na$예정일시 <- gsub("오후 2:", "14:", df_2022_rm_na$예정일시)
df_2022_rm_na$예정일시 <- gsub("오후 3:", "15:", df_2022_rm_na$예정일시)
df_2022_rm_na$예정일시 <- gsub("오후 4:", "16:", df_2022_rm_na$예정일시)
df_2022_rm_na$예정일시 <- gsub("오후 5:", "17:", df_2022_rm_na$예정일시)
df_2022_rm_na$예정일시 <- gsub("오후 6:", "18:", df_2022_rm_na$예정일시)
df_2022_rm_na$예정일시 <- gsub("오후 7:", "19:", df_2022_rm_na$예정일시)
df_2022_rm_na$예정일시 <- gsub("오후 8:", "20:", df_2022_rm_na$예정일시)
df_2022_rm_na$예정일시 <- gsub("오후 9:", "21:", df_2022_rm_na$예정일시)
df_2022_rm_na$예정일시 <- gsub("오후 10:", "22:", df_2022_rm_na$예정일시)
df_2022_rm_na$예정일시 <- gsub("오후 11:", "23:", df_2022_rm_na$예정일시)

df_2022_rm_na$배차일시 <- gsub("오전 12:", "0:", df_2022_rm_na$배차일시)
df_2022_rm_na$배차일시 <- gsub("오전 ", "", df_2022_rm_na$배차일시)
df_2022_rm_na$배차일시 <- gsub("오후 12:", "12:", df_2022_rm_na$배차일시)
df_2022_rm_na$배차일시 <- gsub("오후 1:", "13:", df_2022_rm_na$배차일시)
df_2022_rm_na$배차일시 <- gsub("오후 2:", "14:", df_2022_rm_na$배차일시)
df_2022_rm_na$배차일시 <- gsub("오후 3:", "15:", df_2022_rm_na$배차일시)
df_2022_rm_na$배차일시 <- gsub("오후 4:", "16:", df_2022_rm_na$배차일시)
df_2022_rm_na$배차일시 <- gsub("오후 5:", "17:", df_2022_rm_na$배차일시)
df_2022_rm_na$배차일시 <- gsub("오후 6:", "18:", df_2022_rm_na$배차일시)
df_2022_rm_na$배차일시 <- gsub("오후 7:", "19:", df_2022_rm_na$배차일시)
df_2022_rm_na$배차일시 <- gsub("오후 8:", "20:", df_2022_rm_na$배차일시)
df_2022_rm_na$배차일시 <- gsub("오후 9:", "21:", df_2022_rm_na$배차일시)
df_2022_rm_na$배차일시 <- gsub("오후 10:", "22:", df_2022_rm_na$배차일시)
df_2022_rm_na$배차일시 <- gsub("오후 11:", "23:", df_2022_rm_na$배차일시)

df_2022_rm_na$승차일시 <- gsub("오전 12:", "0:", df_2022_rm_na$승차일시)
df_2022_rm_na$승차일시 <- gsub("오전 ", "", df_2022_rm_na$승차일시)
df_2022_rm_na$승차일시 <- gsub("오후 12:", "12:", df_2022_rm_na$승차일시)
df_2022_rm_na$승차일시 <- gsub("오후 1:", "13:", df_2022_rm_na$승차일시)
df_2022_rm_na$승차일시 <- gsub("오후 2:", "14:", df_2022_rm_na$승차일시)
df_2022_rm_na$승차일시 <- gsub("오후 3:", "15:", df_2022_rm_na$승차일시)
df_2022_rm_na$승차일시 <- gsub("오후 4:", "16:", df_2022_rm_na$승차일시)
df_2022_rm_na$승차일시 <- gsub("오후 5:", "17:", df_2022_rm_na$승차일시)
df_2022_rm_na$승차일시 <- gsub("오후 6:", "18:", df_2022_rm_na$승차일시)
df_2022_rm_na$승차일시 <- gsub("오후 7:", "19:", df_2022_rm_na$승차일시)
df_2022_rm_na$승차일시 <- gsub("오후 8:", "20:", df_2022_rm_na$승차일시)
df_2022_rm_na$승차일시 <- gsub("오후 9:", "21:", df_2022_rm_na$승차일시)
df_2022_rm_na$승차일시 <- gsub("오후 10:", "22:", df_2022_rm_na$승차일시)
df_2022_rm_na$승차일시 <- gsub("오후 11:", "23:", df_2022_rm_na$승차일시)

# 문자열 → 날짜 데이터 변환 (예정일시, 배차일시, 승차일시)
df_2019_rm_na$예정일시 <- as.POSIXct(strptime(df_2019_rm_na$예정일시, format = "%Y-%m-%d %H:%M:%S"))
df_2019_rm_na$배차일시 <- as.POSIXct(strptime(df_2019_rm_na$배차일시, format = "%Y-%m-%d %H:%M:%S"))
df_2019_rm_na$승차일시 <- as.POSIXct(strptime(df_2019_rm_na$승차일시, format = "%Y-%m-%d %H:%M:%S"))

df_2020_rm_na$예정일시 <- as.POSIXct(strptime(df_2020_rm_na$예정일시, format = "%Y-%m-%d %H:%M:%S"))
df_2020_rm_na$배차일시 <- as.POSIXct(strptime(df_2020_rm_na$배차일시, format = "%Y-%m-%d %H:%M:%S"))
df_2020_rm_na$승차일시 <- as.POSIXct(strptime(df_2020_rm_na$승차일시, format = "%Y-%m-%d %H:%M:%S"))

df_2021_rm_na$예정일시 <- as.POSIXct(strptime(df_2021_rm_na$예정일시, format = "%Y-%m-%d %H:%M:%S"))
df_2021_rm_na$배차일시 <- as.POSIXct(strptime(df_2021_rm_na$배차일시, format = "%Y-%m-%d %H:%M:%S"))
df_2021_rm_na$승차일시 <- as.POSIXct(strptime(df_2021_rm_na$승차일시, format = "%Y-%m-%d %H:%M:%S"))

df_2022_rm_na$예정일시 <- as.POSIXct(strptime(df_2022_rm_na$예정일시, format = "%Y-%m-%d %H:%M:%S"))
df_2022_rm_na$배차일시 <- as.POSIXct(strptime(df_2022_rm_na$배차일시, format = "%Y-%m-%d %H:%M:%S"))
df_2022_rm_na$승차일시 <- as.POSIXct(strptime(df_2022_rm_na$승차일시, format = "%Y-%m-%d %H:%M:%S"))

# "대기시간(=승차일시-배차일시, 분(m), 초(s) 단위)" column 생성
df_2019_rm_na$'대기시간(m)' <- round(difftime(df_2019_rm_na$승차일시, df_2019_rm_na$배차일시, units = 'mins'), 2)
df_2020_rm_na$'대기시간(m)' <- round(difftime(df_2020_rm_na$승차일시, df_2020_rm_na$배차일시, units = 'mins'), 2)
df_2021_rm_na$'대기시간(m)' <- round(difftime(df_2021_rm_na$승차일시, df_2021_rm_na$배차일시, units = 'mins'), 2)
df_2022_rm_na$'대기시간(m)' <- round(difftime(df_2022_rm_na$승차일시, df_2022_rm_na$배차일시, units = 'mins'), 2 )

df_2019_rm_na$'대기시간(s)' <- difftime(df_2019_rm_na$승차일시, df_2019_rm_na$배차일시, units = 'secs')
df_2020_rm_na$'대기시간(s)' <- difftime(df_2020_rm_na$승차일시, df_2020_rm_na$배차일시, units = 'secs')
df_2021_rm_na$'대기시간(s)' <- difftime(df_2021_rm_na$승차일시, df_2021_rm_na$배차일시, units = 'secs')
df_2022_rm_na$'대기시간(s)' <- difftime(df_2022_rm_na$승차일시, df_2022_rm_na$배차일시, units = 'secs')

# 정제한 데이터 저장
# 2019년
final_2019_1 <- df_2019_rm_na[1:952795, ]
tail(final_2019_1)

final_2019_2 <- df_2019_rm_na[952796:1351983, ]
tail(final_2019_2)

# write.xlsx(final_2019_1, "data/final_2019_1.xlsx")
# write.xlsx(final_2019_2, "data/final_2019_2.xlsx")

# 2020년
final_2020_1 <- df_2020_rm_na[1:629320, ]
tail(final_2020_1)

final_2020_2 <- df_2020_rm_na[629321:975324, ]
tail(final_2020_2)

# write.xlsx(final_2020_1, "data/final_2020_1.xlsx")
# write.xlsx(final_2020_2, "data/final_2020_2.xlsx")

# 2021년
final_2021_1 <- df_2021_rm_na[1:806200, ]
tail(final_2021_1)

final_2021_2 <- df_2021_rm_na[806201:1222937, ]
tail(final_2021_2)

# write.xlsx(final_2021_1, "data/final_2021_1.xlsx")
# write.xlsx(final_2021_2, "data/final_2021_2.xlsx")

# 2022년
final_2022 <- df_2022_rm_na
tail(final_2022)

# write.xlsx(final_2022, "data/final_2022.xlsx")

# 출발지구군 기준 구별 대기시간 계산
df_2019_rm_na$`대기시간(m)_num` <- as.numeric(df_2019_rm_na$`대기시간(m)`)
mean_wait_gu_2019 <- df_2019_rm_na %>% 
  group_by(출발지구군) %>% 
  summarise(mean_waiting_mins = round(mean(`대기시간(m)_num`, na.rm = T), 2)) %>% # 종로구(승차일시가 배차일시보다 빠름), 1건
  arrange(desc(mean_waiting_mins))

sum(is.na(df_2019_rm_na)) # 39
na_df_2019 <- df_2019_rm_na[!complete.cases(df_2019_rm_na), ]

df_2020_rm_na$`대기시간(m)_num` <- as.numeric(df_2020_rm_na$`대기시간(m)`)
mean_wait_gu_2020 <- df_2020_rm_na %>% 
  group_by(출발지구군) %>% 
  summarise(mean_waiting_mins = round(mean(`대기시간(m)_num`, na.rm = T), 2)) %>% # 관악구, 영등포구(배차일시 1건, 승차일시 1건), 2건
  arrange(desc(mean_waiting_mins))

sum(is.na(df_2020_rm_na)) # 43
na_df_2020 <- df_2020_rm_na[!complete.cases(df_2020_rm_na), ]

df_2021_rm_na$`대기시간(m)_num` <- as.numeric(df_2021_rm_na$`대기시간(m)`)
mean_wait_gu_2021 <- df_2021_rm_na %>% 
  group_by(출발지구군) %>% 
  summarise(mean_waiting_mins = round(mean(`대기시간(m)_num`, na.rm = T), 2)) %>% # 강서구 (승차일시), 1건
  arrange(desc(mean_waiting_mins))

sum(is.na(df_2021_rm_na)) # 34
na_df_2021 <- df_2021_rm_na[!complete.cases(df_2021_rm_na), ]

df_2022_rm_na$`대기시간(m)_num` <- as.numeric(df_2022_rm_na$`대기시간(m)`)
mean_wait_gu_2022 <- df_2022_rm_na %>% 
  group_by(출발지구군) %>% 
  summarise(mean_waiting_mins = round(mean(`대기시간(m)_num`, na.rm = T), 2)) %>% # 없음
  filter(mean_waiting_mins > 0) %>% # 평균 대기 시간이 0 이상인 것만 추출(마포구 1건, 강남구 2건)
  arrange(desc(mean_waiting_mins))


sum(is.na(df_2022_rm_na)) # 26
na_df_2022 <- df_2022_rm_na[!complete.cases(df_2022_rm_na), ]

# 출발지구군별 대기시간 그래프 구현
# 2019년
ggplot(data = mean_wait_gu_2019, aes(y = reorder(출발지구군,mean_waiting_mins), x = mean_waiting_mins)) +
  geom_col() +
  theme_bw() + 
  ggtitle('2019년 서울시 구별 평균 대기 시간(분)') +
  xlab('평균 대기 시간(분)') +
  ylab('출발지구군') +
  xlim(0, 60) +
  # scale_x_continuous(breaks = seq(0, 60, 5)) +
  theme(plot.title = element_text(face = 'bold', hjust = .5))

# 2020년
ggplot(data = mean_wait_gu_2020, aes(y = reorder(출발지구군, mean_waiting_mins), x = mean_waiting_mins)) +
  geom_col() +
  theme_bw() + 
  ggtitle('2020년 서울시 구별 평균 대기 시간(분)') +
  xlab('평균 대기 시간(분)') +
  ylab('출발지구군') +
  xlim(0, 60) +
  # scale_x_continuous(breaks = seq(0, 60, 5)) +
  theme(plot.title = element_text(face = 'bold', hjust = .5))

# 2021년
ggplot(data = mean_wait_gu_2021, aes(y = reorder(출발지구군, mean_waiting_mins), x = mean_waiting_mins)) +
  geom_col() +
  theme_bw() + 
  ggtitle('2021년 서울시 구별 평균 대기 시간(분)') +
  xlab('평균 대기 시간(분)') +
  ylab('출발지구군') +
  xlim(0, 60) +
  # scale_x_continuous(breaks = seq(0, 60, 5)) +
  theme(plot.title = element_text(face = 'bold', hjust = .5))

# 2022년
ggplot(data = mean_wait_gu_2022, aes(y = reorder(출발지구군, mean_waiting_mins), x = mean_waiting_mins)) +
  geom_col() +
  theme_bw() + 
  ggtitle('2022년 서울시 구별 평균 대기 시간(분)') +
  xlab('평균 대기 시간(분)') +
  ylab('출발지구군') +
  xlim(0, 60) +
  # scale_x_continuous(breaks = seq(0, 60, 10)) +
  theme(plot.title = element_text(face = 'bold', hjust = .5))

######## 다시----
df_2019_1 <- read_excel('C:/Users/user/Desktop/Python/NRC(콜택시)/data/장애인콜시스템(19.01.01~19.08.31).xlsx', sheet = 2)
df_2019_2 <- read_excel('C:/Users/user/Desktop/Python/NRC(콜택시)/data/장애인콜시스템(19.09.01~19.12.31).xlsx', sheet = 2)
df_2019 <- rbind(df_2019, df_2019_2)
df_2020_1 <- read_excel('C:/Users/user/Desktop/Python/NRC(콜택시)/data/장애인콜시스템(20.01.01~20.08.31).xlsx', sheet = 2)
df_2020_2 <- read_excel('C:/Users/user/Desktop/Python/NRC(콜택시)/data/장애인콜시스템(20.09.01~20.12.31).xlsx', sheet = 2)
df_2020 <- rbind(df_2020_1, df_2020_2)
df_2021_1 <- read_excel('C:/Users/user/Desktop/Python/NRC(콜택시)/data/장애인콜시스템(21.01.01~21.08.31).xlsx', sheet = 2)
df_2021_2 <- read_excel('C:/Users/user/Desktop/Python/NRC(콜택시)/data/장애인콜시스템(21.09.01~21.12.31).xlsx', sheet = 2)
df_2021 <- rbind(df_2021_1, df_2021_2)
df_2022 <- read_excel('C:/Users/user/Desktop/Python/NRC(콜택시)/data/장애인콜시스템(22.01.01~22.08.20).xlsx', sheet = 2)

# 대시기간 데이터 형 변환
df_2019$`대기시간(m)` <- as.integer(df_2019$`대기시간(m)`)
df_2020$`대기시간(m)` <- as.integer(df_2020$`대기시간(m)`)
df_2021$`대기시간(m)` <- as.integer(df_2021$`대기시간(m)`)
df_2022$`대기시간(m)` <- as.integer(df_2022$`대기시간(m)`)
summary(df_2019 %>% filter(출발지구군 == '성북구') %>% select('대기시간(m)'))

# 출발지구군 기준 구별 대기시간 계산
max_wait_gu_2019 <- df_2019 %>% 
  group_by(출발지구군) %>% 
  summarise(max_waiting_mins = round(max(`대기시간(m)`, na.rm = T), 2))
  arrange(desc(max_waiting_mins))

sum(is.na(df_2019)) # 35 (예정일시가 na)
na_df_2019 <- df_2019[!complete.cases(df_2019), ]

max_wait_gu_2020 <- df_2020 %>% 
  group_by(출발지구군) %>% 
  summarise(max_waiting_mins = round(max(`대기시간(m)`, na.rm = T), 2)) %>%
  arrange(desc(max_waiting_mins))

sum(is.na(df_2020)) # 35 (예정일시가 na)
na_df_2020 <- df_2020[!complete.cases(df_2020), ]

max_wait_gu_2021 <- df_2021 %>% 
  group_by(출발지구군) %>% 
  summarise(max_waiting_mins = round(max(`대기시간(m)`, na.rm = T), 2)) %>% # 강서구 (승차일시), 1건
  arrange(desc(max_waiting_mins))

sum(is.na(df_2021)) # 30 (예정일시가 na)
na_df_2021 <- df_2021[!complete.cases(df_2021), ]

max_wait_gu_2022 <- df_2022 %>% 
  group_by(출발지구군) %>% 
  summarise(max_waiting_mins = round(max(`대기시간(m)`, na.rm = T), 2)) %>% # 없음
  arrange(desc(max_waiting_mins))

sum(is.na(df_2022)) # 26 (예정일시가 na)
na_df_2022 <- df_2022[!complete.cases(df_2022), ]

# max_wait_gu_2019[30,1] <- '인천부평구'
# max_wait_gu_2019[48,1] <- '인천남동구'

# max_wait_gu_2020[40,1] <- '인천부평구'
# max_wait_gu_2020[45,1] <- '인천남동구'

# max_wait_gu_2021[43,1] <- '인천부평구'
# max_wait_gu_2021[46,1] <- '인천서구'
# max_wait_gu_2021[48,1] <- '인천남동구'
# max_wait_gu_2021[55,1] <- '인천계양구'

# max_wait_gu_2022[42,1] <- '인천부평구'
# max_wait_gu_2022[47,1] <- '인천남동구'
# max_wait_gu_2022[49,1] <- '인천계양구'

# 출발지구군별 대기시간 그래프 구현
# 2019년
ggplot(data = max_wait_gu_2019, aes(y = reorder(출발지구군, max_waiting_mins), x = max_waiting_mins)) +
  geom_col() +
  theme_bw() + 
  ggtitle('2019년 서울시 구별 최대 대기 시간(분)') +
  xlab('최대 대기 시간(분)') +
  ylab('출발지구군') +
  # xlim(0, 60) +
  # scale_x_continuous(breaks = seq(0, 60, 5)) +
  theme(plot.title = element_text(face = 'bold', hjust = .5))

# 2020년
ggplot(data = max_wait_gu_2020, aes(y = reorder(출발지구군, max_waiting_mins), x = max_waiting_mins)) +
  geom_col() +
  theme_bw() + 
  ggtitle('2020년 서울시 구별 최대 대기 시간(분)') +
  xlab('최대 대기 시간(분)') +
  ylab('출발지구군') +
  # xlim(0, 60) +
  # scale_x_continuous(breaks = seq(0, 60, 5)) +
  theme(plot.title = element_text(face = 'bold', hjust = .5))

# 2021년
ggplot(data = max_wait_gu_2021, aes(y = reorder(출발지구군, max_waiting_mins), x = max_waiting_mins)) +
  geom_col() +
  theme_bw() + 
  ggtitle('2021년 서울시 구별 최대 대기 시간(분)') +
  xlab('최대 대기 시간(분)') +
  ylab('출발지구군') +
  # xlim(0, 60) +
  # scale_x_continuous(breaks = seq(0, 60, 5)) +
  theme(plot.title = element_text(face = 'bold', hjust = .5))

# 2022년
ggplot(data = max_wait_gu_2022, aes(y = reorder(출발지구군, max_waiting_mins), x = max_waiting_mins)) +
  geom_col() +
  theme_bw() + 
  ggtitle('2022년 서울시 구별 최대 대기 시간(분)') +
  xlab('최대 대기 시간(분)') +
  ylab('출발지구군') +
  # xlim(0, 60) +
  # scale_x_continuous(breaks = seq(0, 60, 10)) +
  theme(plot.title = element_text(face = 'bold', hjust = .5))

# 2021년 정제 데이터만 csv 저장
# preprodf_2021_1 <- read_excel('C:/Users/user/Desktop/Python/NRC(콜택시)/data/장애인콜시스템(21.01.01~21.08.31).xlsx', sheet = 2)
# preprodf_2021_2 <- read_excel('C:/Users/user/Desktop/Python/NRC(콜택시)/data/장애인콜시스템(21.09.01~21.12.31).xlsx', sheet = 2)

preprodf_2021 <- rbind(preprodf_2021_1, preprodf_2021_2)

write.csv(preprodf_2021, 'data/장애인콜시스템(21.01.01~21.12.31)정제ver.csv')
