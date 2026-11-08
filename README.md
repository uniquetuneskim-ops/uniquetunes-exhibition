# UNIQUETUNES 12 — 마지막 앵콜 (공개용)

누구나 링크로 들어와 이름을 입력하고, 다른 관객과 함께 전시실을 걸으며 영상을 보고 댓글을 남기는 버전입니다.
실시간 관객 표시와 댓글은 Supabase(무료 플랜)로 동작합니다.

## 1. Supabase 준비 (10분)
1. supabase.com 가입 → New project 생성 (Region: Northeast Asia (Seoul) 권장)
2. 왼쪽 메뉴 SQL Editor → `setup.sql` 내용을 붙여넣고 Run
3. Authentication → Sign In / Providers → **Allow anonymous sign-ins** 켜기
   (관객이 회원가입 없이 이름만 입력하고 댓글을 쓰기 위한 설정)
4. Project Settings → API 에서 두 값을 복사
   - Project URL
   - anon public key (공개용 키라 페이지에 넣어도 됩니다. service_role 키는 절대 넣지 마세요)

## 2. index.html 설정
파일 위쪽 `CONFIG` 에서
- `supabaseUrl`, `supabaseAnonKey` 에 위 두 값 붙여넣기
- 전시실(rooms) · 작품(works) · 배경음악(tracks) · 마지막 인사(letter) 내용 채우기
- 영상·음원·사진은 `media` 폴더에 넣고 경로를 `"media/파일이름.mp4"` 처럼 적기

## 3. 공개하기
Netlify Drop(app.netlify.com/drop)에 이 폴더를 통째로 끌어다 놓으면 주소가 바로 생깁니다.
원하는 도메인 연결도 Netlify에서 할 수 있습니다.

## 운영 메모
- 부적절한 댓글은 Supabase → Table Editor → comments 에서 해당 줄을 지우면 모든 관객 화면에서 사라집니다.
- 무료 플랜은 동시 접속과 초당 메시지 수에 한도가 있습니다. 공개 당일 동시에 수십 명 이상 몰릴 것 같으면 그날만 Pro 플랜으로 올리는 것을 권합니다.
- 영상 용량이 크면 업로드·재생이 느려집니다. 1080p 기준 H.264로 압축해서 올리는 것을 권합니다.
